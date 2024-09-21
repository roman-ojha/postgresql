/*
  Warnings:

  - You are about to drop the column `is_delivered` on the `Order` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('pending', 'processing', 'cancelled', 'delivered');

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "is_delivered",
ADD COLUMN     "status" "OrderStatus" NOT NULL DEFAULT 'pending';
