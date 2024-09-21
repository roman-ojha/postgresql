import { prisma } from "../connection";
import { ProductRequest } from "../types/product";
import { slugifyWithHash } from "../../utils/slugify";
import { Prisma } from "@prisma/client";
import { PaginationQuery } from "../../types/others";
import { UploadedPictureMetaData } from "../types";
import { ConflictError, InternalServerError } from "../../utils/app-error";

class ProductRepository {
  standardProductSelect: Prisma.ProductSelect;

  constructor() {
    this.standardProductSelect = {
      id: true,
      name: true,
      price: true,
      pictures: {
        select: {
          url: true,
        },
      },
      description: true,
      is_in_stock: true,
      discount_price: true,
      discount_upto: true,
      available_quantity: true,
      slug: true,
      created_at: true,
      updated_at: true,
      category: {
        select: {
          id: true,
          name: true,
        },
      },
    };
  }

  async create(data: {
    fieldData: ProductRequest;
    uploadedPictureMetadata: UploadedPictureMetaData[];
  }) {
    const pictures = data.uploadedPictureMetadata.map((pictures) => {
      return <Prisma.ProductPictureCreateInput>{
        url: pictures.publicUrl,
        blob_name: pictures.blobName,
        bucket_name: pictures.bucketName,
      };
    });
    return await prisma.product.create({
      data: {
        name: data.fieldData.name,
        price: data.fieldData.price,
        description: data.fieldData.description,
        is_in_stock: data.fieldData.is_in_stock,
        discount_price: data.fieldData.discount_price,
        discount_upto: data.fieldData.discount_upto,
        available_quantity: data.fieldData.available_quantity,
        slug: slugifyWithHash(data.fieldData.name, 20),
        pictures: {
          create: pictures,
        },
        category: {
          connect: { id: data.fieldData.category_id },
        },
      },
      select: this.standardProductSelect,
    });
  }

  async updateById(data: {
    productId: number;
    productDetail: ProductRequest;
    uploadedPictureMetadata?: UploadedPictureMetaData[];
  }) {
    let pictures: Prisma.ProductPictureCreateInput[] | undefined;
    if (data.uploadedPictureMetadata) {
      pictures = data.uploadedPictureMetadata.map((pictures) => {
        return <Prisma.ProductPictureCreateInput>{
          url: pictures.publicUrl,
          blob_name: pictures.blobName,
          bucket_name: pictures.bucketName,
        };
      });
    }
    if (!pictures) {
      return await prisma.product.update({
        where: {
          id: data.productId,
        },
        data: {
          name: data.productDetail.name,
          price: data.productDetail.price,
          description: data.productDetail.description,
          is_in_stock: data.productDetail.is_in_stock,
          discount_price: data.productDetail.discount_price,
          discount_upto: data.productDetail.discount_upto,
          available_quantity: data.productDetail.available_quantity,
          slug: slugifyWithHash(data.productDetail.name, 16),
          category: {
            connect: { id: data.productDetail.category_id },
          },
        },
        select: this.standardProductSelect,
      });
    }

    // delete previously added product picture first
    const deleteResponse = await prisma.productPicture.deleteMany({
      where: {
        product_id: data.productId,
      },
    });

    if (deleteResponse) {
      return await prisma.product.update({
        where: {
          id: data.productId,
        },
        data: {
          name: data.productDetail.name,
          price: data.productDetail.price,
          description: data.productDetail.description,
          is_in_stock: data.productDetail.is_in_stock,
          discount_price: data.productDetail.discount_price,
          discount_upto: data.productDetail.discount_upto,
          available_quantity: data.productDetail.available_quantity,
          slug: slugifyWithHash(data.productDetail.name, 16),
          pictures: {
            create: pictures,
          },
          category: {
            connect: { id: data.productDetail.category_id },
          },
        },
        select: this.standardProductSelect,
      });
    } else throw new InternalServerError();
  }

  async count() {
    return await prisma.product.count();
  }

  async getWithPagination(data: PaginationQuery) {
    const skip = (data.page - 1) * data.limit;
    return await prisma.product.findMany({
      where: {
        is_in_stock: true,
      },
      skip,
      take: data.limit,
      orderBy: {
        id: "asc",
      },
      select: this.standardProductSelect,
    });
  }

  async getTopSellingWithPagination(data: PaginationQuery) {
    const skip = (data.page - 1) * data.limit;
    return await prisma.product.findMany({
      where: {
        is_in_stock: true,
      },
      skip,
      take: data.limit,
      orderBy: {
        ordered_products: {
          _count: "desc",
        },
      },
      // include: {
      //   _count: {
      //     select: {
      //       ordered_products: true,
      //     },
      //   },
      // },
      select: this.standardProductSelect,
    });
  }

  async getTopRatedWithPagination(data: PaginationQuery) {
    const skip = (data.page - 1) * data.limit;
    const highRatedProducts = await prisma.rate.groupBy({
      by: ["product_id"],
      _avg: {
        star: true,
      },
      orderBy: {
        _avg: {
          star: "desc",
        },
      },
      take: data.limit,
      skip,
    });
    const highRatedProductId = highRatedProducts.map((data) => data.product_id);
    return await prisma.product.findMany({
      where: {
        id: {
          in: highRatedProductId,
        },
      },
      select: this.standardProductSelect,
    });
  }

  async getBySlug(slug: string) {
    return await prisma.product.findFirst({
      where: {
        slug,
      },
      select: this.standardProductSelect,
    });
  }

  async getById(id: number) {
    return await prisma.product.findFirst({
      where: {
        id,
      },
      select: this.standardProductSelect,
    });
  }

  async deleteById(id: number) {
    // can't perform delete operation if product is already associated to 'Cart' & 'Order' etc..., so will first check it.
    const carts = await prisma.cart.findFirst({
      where: {
        product_id: id,
      },
    });
    const orderProduct = await prisma.orderedProducts.findFirst({
      where: {
        product_id: id,
      },
    });
    if (carts || orderProduct)
      throw new ConflictError(
        "Not permitted: Product is already added into cart or has already been ordered by user."
      );
    return await prisma.product.delete({
      where: {
        id,
      },
      select: this.standardProductSelect,
    });
  }

  async findMany() {
    return await prisma.product.findMany({
      select: this.standardProductSelect,
    });
  }

  async getByIds(ids: number[]) {
    return await prisma.product.findMany({
      where: {
        id: {
          in: ids,
        },
      },
      select: this.standardProductSelect,
    });
  }

  async getByCategoryId(id: number) {
    return await prisma.product.findMany({
      where: {
        category_id: id,
      },
      select: {
        id: true,
        name: true,
        category: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });
  }
}

export default ProductRepository;
