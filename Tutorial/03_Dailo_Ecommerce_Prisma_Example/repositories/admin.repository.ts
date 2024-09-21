import { Prisma } from "@prisma/client";
import { prisma } from "../connection";

class AdminRepository {
  async getAdminByEmail(email: string) {
    return prisma.admin.findFirst({
      where: {
        email,
      },
    });
  }

  async getSafeAdminByEmail(email: string) {
    return prisma.admin.findFirst({
      where: {
        email,
      },
      select: {
        id: true,
        email: true,
        created_at: true,
        is_verified: true,
        updated_at: true,
      },
    });
  }

  async createNewAdmin(user: Prisma.AdminCreateInput) {
    return prisma.admin.create({
      data: user,
    });
  }
}

export default AdminRepository;
