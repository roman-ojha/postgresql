import { Prisma } from "@prisma/client";
import { prisma } from "../connection";

class UserRepository {
  async getUserByEmail(email: string) {
    return prisma.user.findFirst({
      where: {
        email: email,
      },
    });
  }

  async getUserById(id: number) {
    return prisma.user.findFirst({
      where: {
        id,
      },
    });
  }

  async findMany() {
    return prisma.user.findMany();
  }

  async createNewUser(user: Prisma.UserCreateInput) {
    return prisma.user.create({
      data: user,
    });
  }

  async createMany(users: Prisma.UserCreateInput[]) {
    return prisma.user.createMany({
      data: users,
    });
  }
}

export default UserRepository;
