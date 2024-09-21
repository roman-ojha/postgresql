/*
  Warnings:

  - You are about to drop the column `product_id` on the `Order` table. All the data in the column will be lost.
  - Added the required column `total_discount_price` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_purchased_price` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_product_id_fkey";

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "product_id",
ADD COLUMN     "total_discount_price" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "total_purchased_price" DOUBLE PRECISION NOT NULL;
