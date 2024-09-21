import { Order, Prisma, User } from "@prisma/client";
import { prisma } from "../connection";
import { PaginationQuery } from "../../types/others";
import { CreateOrderInput } from "../types/order";

export default class OrderRepository {
  standardSelect: Prisma.OrderSelect = {
    id: true,
    user_id: true,
    shipping_address_id: true,
    total_purchased_price: true,
    total_discount_price: true,
    is_payment_completed: true,
    validate_upto_before_payment: true,
    delivery_day: true,
    payment_method: true,
    shipping_method: true,
    shipping_address: true,
    user: true,
    status: true,
    created_at: true,
    updated_at: true,
    ordered_products: {
      select: {
        id: true,
        discount_price: true,
        purchased_price: true,
        quantity: true,
        product_id: true,
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
    },
  };

  async create(data: CreateOrderInput) {
    return prisma.order.create({
      data: {
        total_discount_price: data.total_discount_price,
        total_purchased_price: data.total_purchased_price,
        shipping_address: {
          connect: {
            id: data.shipping_address_id,
          },
        },
        validate_upto_before_payment: data.validate_upto_before_payment,
        delivery_day: data.delivery_day,
        payment_method: data.payment_method,
        shipping_method: data.shipping_method,
        ordered_products: {
          create: data.ordered_products.map((orderProductDetail) => {
            return {
              discount_price: orderProductDetail.discount_price,
              product_id: orderProductDetail.product_id,
              purchased_price: orderProductDetail.purchased_price,
              quantity: orderProductDetail.quantity,
            };
          }),
        },
        user: {
          connect: {
            id: data.user_id,
          },
        },
      },
      select: this.standardSelect,
    });
  }

  async getById(id: number) {
    return await prisma.order.findFirst({
      where: {
        id,
      },
      select: this.standardSelect,
    });
  }

  async getByUserIdWithPagination(data: {
    pagination: PaginationQuery;
    user_id: User["id"];
  }) {
    const skip = (data.pagination.page - 1) * data.pagination.limit;
    return await prisma.order.findMany({
      skip,
      take: data.pagination.limit,
      orderBy: {
        id: "desc",
      },
      where: {
        user_id: data.user_id,
      },
      select: this.standardSelect,
    });
  }

  async getsByPayedWithPagination(pagination: PaginationQuery) {
    const skip = (pagination.page - 1) * pagination.limit;
    return await prisma.order.findMany({
      skip,
      take: pagination.limit,
      orderBy: {
        id: "desc",
      },
      select: this.standardSelect,
    });
  }

  async changeStatusOfOrder(orderId: Order["id"], status: Order["status"]) {
    return await prisma.order.update({
      where: {
        id: orderId,
      },
      data: {
        status,
      },
    });
  }

  async changeStatusToCompleted(orderId: Order["id"]) {
    return await prisma.order.update({
      where: {
        id: orderId,
      },
      data: {
        status: "COMPLETED",
        is_payment_completed: true,
      },
    });
  }

  async changeStatusToCancelled(orderId: Order["id"]) {
    return await prisma.order.update({
      where: {
        id: orderId,
      },
      data: {
        status: "CANCELLED",
      },
    });
  }

  async countByUserId(user_id: User["id"]) {
    return await prisma.order.count({
      where: {
        user_id,
      },
    });
  }

  async countAll() {
    return await prisma.order.count();
  }

  async countNotPayedByUserId(user_id: User["id"]) {
    return await prisma.order.count({
      where: {
        user_id,
        is_payment_completed: false,
      },
    });
  }
}
