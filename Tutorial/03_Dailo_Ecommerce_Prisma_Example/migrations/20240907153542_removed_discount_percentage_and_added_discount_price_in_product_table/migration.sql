/*
  Warnings:

  - You are about to drop the column `discount_percent` on the `Product` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Product" DROP COLUMN "discount_percent",
ADD COLUMN     "discount_price" DOUBLE PRECISION NOT NULL DEFAULT 0;
