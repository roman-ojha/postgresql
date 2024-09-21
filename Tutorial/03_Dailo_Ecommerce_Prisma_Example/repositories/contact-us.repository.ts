import { PaginationQuery } from "../../types/others";
import { prisma } from "../connection";
import { AddNewContactUs } from "../types/contact-us";

class ContactUsRepository {
  async create({ name, email, phone_number, message }: AddNewContactUs) {
    return await prisma.contactUs.create({
      data: {
        name,
        email,
        phone_number,
        message,
      },
    });
  }

  async getWithPagination(pagination: PaginationQuery) {
    const skip = (pagination.page - 1) * pagination.limit;
    return await prisma.contactUs.findMany({
      skip,
      take: pagination.limit,
      orderBy: {
        id: "desc",
      },
    });
  }

  async count() {
    return await prisma.contactUs.count();
  }
}

export default ContactUsRepository;
