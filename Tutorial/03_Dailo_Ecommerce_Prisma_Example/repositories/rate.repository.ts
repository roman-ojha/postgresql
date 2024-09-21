import { Prisma, Product, User } from "@prisma/client";
import { prisma } from "../connection";
import { RateCreateRequest } from "../types/rate";
import { PaginationQuery } from "../../types/others";
import { NotAcceptableError } from "../../utils/app-error";

class RateRepository {
  standardRateSelect: Prisma.RateSelect = {
    id: true,
    star: true,
    comment: true,
    user_id: true,
    product_id: true,
    created_at: true,
    updated_at: true,
  };

  async create(data: RateCreateRequest) {
    if (data.star > 5 || data.star < 1)
      throw new NotAcceptableError("Star value needs to be from '1' to '5'.");
    return prisma.rate.create({
      data: {
        comment: data.comment,
        star: data.star,
        product_id: data.product_id,
        user_id: data.user_id,
      },
      select: this.standardRateSelect,
    });
  }

  async createMany(data: RateCreateRequest[]) {
    return prisma.rate.createMany({
      data,
    });
  }

  async count(product_id: Product["id"]) {
    return prisma.rate.count({
      where: {
        product_id,
      },
    });
  }

  async countByUserId(id: User["id"]) {
    return prisma.rate.count({
      where: {
        user_id: id,
      },
    });
  }

  async getPaginatedByProductId(query: {
    product_id: Product["id"];
    pagination: PaginationQuery;
  }) {
    const skip = (query.pagination.page - 1) * query.pagination.limit;
    return prisma.rate.findMany({
      skip,
      take: query.pagination.limit,
      orderBy: {
        id: "desc",
      },
      where: {
        product_id: query.product_id,
      },
      select: {
        ...this.standardRateSelect,
        user: {
          select: {
            email: true,
            picture: true,
            name: true,
          },
        },
      },
    });
  }

  async getPaginatedByUserId(query: {
    user_id: Product["id"];
    pagination: PaginationQuery;
  }) {
    const skip = (query.pagination.page - 1) * query.pagination.limit;
    return prisma.rate.findMany({
      skip,
      take: query.pagination.limit,
      orderBy: {
        id: "desc",
      },
      where: {
        user_id: query.user_id,
      },
      select: {
        ...this.standardRateSelect,
        product: {
          select: {
            name: true,
            pictures: {
              take: 1,
              orderBy: {
                id: "asc",
              },
              select: {
                id: true,
                url: true,
              },
            },
          },
        },
      },
    });
  }

  async getRatesMetadataByProductId(product_id: number) {
    const averageRating = await prisma.rate.aggregate({
      _avg: {
        star: true,
      },
      where: {
        product_id,
      },
    });
    const totalRating = await prisma.rate.count({
      where: {
        product_id,
      },
    });
    const starCounts: { star: number; totalCount: number }[] = (
      await prisma.rate.groupBy({
        where: {
          product_id,
        },
        by: ["star"],
        _count: {
          star: true,
        },
        orderBy: {
          star: "desc", // Sort by 'star' in descending order
        },
      })
    ).map((data) => {
      return {
        star: data.star,
        totalCount: data._count.star,
      };
    });
    return {
      averageRating: averageRating._avg.star || 0,
      totalRating,
      starCounts,
    };
  }

  async getRatesMetadataByUserId(id: number) {
    const averageRating = await prisma.rate.aggregate({
      _avg: {
        star: true,
      },
      where: {
        user_id: id,
      },
    });
    const totalRating = await prisma.rate.count({
      where: {
        user_id: id,
      },
    });
    const starCounts: { star: number; totalCount: number }[] = (
      await prisma.rate.groupBy({
        where: {
          user_id: id,
        },
        by: ["star"],
        _count: {
          star: true,
        },
        orderBy: {
          star: "desc", // Sort by 'star' in descending order
        },
      })
    ).map((data) => {
      return {
        star: data.star,
        totalCount: data._count.star,
      };
    });
    return {
      averageRating: averageRating._avg.star || 0,
      totalRating,
      starCounts,
    };
  }
}

export default RateRepository;
