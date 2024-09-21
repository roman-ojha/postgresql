import { Cart } from "@prisma/client";
import { prisma } from "../connection";
import { AddToCart } from "../types/cart";

class CartRepository {
  async getByUserAndProduct({
    product_id,
    user_id,
  }: {
    product_id: number;
    user_id: number;
  }) {
    return prisma.cart.findFirst({
      where: {
        product_id,
        user_id,
      },
    });
  }

  async create({ product_id, quantity, user_id }: AddToCart) {
    return prisma.cart.create({
      data: {
        product_id,
        user_id,
        quantity,
      },
      select: {
        id: true,
        product_id: true,
        user_id: true,
        quantity: true,
        created_at: true,
        updated_at: true,
      },
    });
  }

  async updateQuantityById({
    quantity,
    id,
  }: {
    id: Cart["id"];
    quantity: Cart["quantity"];
  }) {
    return prisma.cart.update({
      where: {
        id,
      },
      data: {
        quantity,
      },
    });
  }

  async getByUserId(user_id: number) {
    return prisma.cart.findMany({
      where: {
        user_id,
      },
      select: {
        id: true,
        product: {
          select: {
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
          },
        },
        user_id: true,
        quantity: true,
        created_at: true,
        updated_at: true,
      },
    });
  }

  async getById(id: number) {
    return prisma.cart.findFirst({
      where: {
        id,
      },
    });
  }

  async getByIdsWithProductDetail(ids: number[]) {
    return prisma.cart.findMany({
      where: {
        id: {
          in: ids,
        },
      },
      select: {
        id: true,
        quantity: true,
        user_id: true,
        product: {
          select: {
            id: true,
            name: true,
            is_in_stock: true,
            available_quantity: true,
            discount_price: true,
            discount_upto: true,
            price: true,
          },
        },
      },
    });
  }

  async deleteById(id: number) {
    return prisma.cart.delete({
      where: {
        id,
      },
    });
  }

  async deleteManyByUserId(data: { cart_ids: number[]; user_id: number }) {
    return prisma.cart.deleteMany({
      where: {
        id: {
          in: data.cart_ids,
        },
        user_id: data.user_id,
      },
    });
  }
}

export default CartRepository;
