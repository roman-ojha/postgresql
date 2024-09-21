import { ShippingAddress, User } from "@prisma/client";
import { prisma } from "../connection";
import { CreateUpdateShippingAddressRequest } from "../types/shipping-address";

export default class ShippingAddressRepository {
  async create({
    data,
    user_id,
  }: {
    data: CreateUpdateShippingAddressRequest;
    user_id: User["id"];
  }) {
    return await prisma.shippingAddress.create({
      data: {
        first_name: data.first_name,
        last_name: data.last_name,
        house_number_and_street_name: data.house_number_and_street_name,
        apartment_or_suite_or_unit: data.apartment_or_suite_or_unit,
        phone_no: data.phone_no,
        town_or_city_name: data.town_or_city_name,
        user: {
          connect: {
            id: user_id,
          },
        },
      },
    });
  }

  async updateById({
    data,
    shipping_address_id,
  }: {
    data: CreateUpdateShippingAddressRequest;
    shipping_address_id: ShippingAddress["id"];
  }) {
    return await prisma.shippingAddress.update({
      where: {
        id: shipping_address_id,
      },
      data: {
        first_name: data.first_name,
        last_name: data.last_name,
        house_number_and_street_name: data.house_number_and_street_name,
        apartment_or_suite_or_unit: data.apartment_or_suite_or_unit,
        phone_no: data.phone_no,
        town_or_city_name: data.town_or_city_name,
      },
    });
  }

  async getAllByUserId(id: User["id"]) {
    return await prisma.shippingAddress.findMany({
      where: {
        user_id: id,
      },
    });
  }

  async getById(id: ShippingAddress["id"]) {
    return await prisma.shippingAddress.findFirst({
      where: {
        id,
      },
    });
  }
}
