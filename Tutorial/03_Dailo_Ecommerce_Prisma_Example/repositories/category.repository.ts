import { Category, Prisma } from "@prisma/client";
import { prisma } from "../connection";
import { UploadedPictureMetaData } from "../types";
import { ConflictError } from "../../utils/app-error";

class CategoryRepository {
  defaultCategorySelect: Prisma.CategorySelect;
  constructor() {
    this.defaultCategorySelect = {
      id: true,
      name: true,
      picture_url: true,
      created_at: true,
      updated_at: true,
    };
  }

  async create(data: Prisma.CategoryCreateInput) {
    return await prisma.category.create({
      data,
      select: this.defaultCategorySelect,
    });
  }

  async createManyAndReturn(data: Prisma.CategoryCreateInput[]) {
    return await prisma.category.createManyAndReturn({
      data: data,
      select: {
        id: true,
        name: true,
      },
    });
  }

  async findMany() {
    return prisma.category.findMany();
  }

  async getWithName(name: string) {
    return await prisma.category.findFirst({
      where: {
        name: name,
      },
      select: this.defaultCategorySelect,
    });
  }

  async getById(id: number) {
    return await prisma.category.findFirst({
      where: {
        id: id,
      },
      select: this.defaultCategorySelect,
    });
  }

  async getAll() {
    return await prisma.category.findMany({
      select: this.defaultCategorySelect,
    });
  }

  async getPopular(noOfItems: number) {
    // Fetching 'noOfItems' of categories based on number of products in each category
    return await prisma.category.findMany({
      take: noOfItems,
      orderBy: {
        products: {
          _count: "desc",
        },
      },
      select: this.defaultCategorySelect,
    });
  }

  async deleteById(id: number) {
    // check first whether product is already been created using given category id or not if so, the you can't be able to delete category.
    const getProducts = await prisma.product.findFirst({
      where: {
        category_id: id,
      },
    });
    if (getProducts)
      throw new ConflictError(
        "Not permitted: Product with given category already exist."
      );
    return await prisma.category.delete({
      where: {
        id: id,
      },
      select: this.defaultCategorySelect,
    });
  }

  async updateById(category: {
    id: number;
    name: Category["name"];
    picture?: UploadedPictureMetaData;
  }) {
    if (category.picture) {
      return await prisma.category.update({
        where: {
          id: category.id,
        },
        data: {
          name: category.name,
          blob_name: category.picture.blobName,
          picture_url: category.picture.publicUrl,
          picture_bucket_name: category.picture.bucketName,
        },
        select: this.defaultCategorySelect,
      });
    }
    return await prisma.category.update({
      where: {
        id: category.id,
      },
      data: {
        name: category.name,
      },
      select: this.defaultCategorySelect,
    });
  }
}

export default CategoryRepository;
