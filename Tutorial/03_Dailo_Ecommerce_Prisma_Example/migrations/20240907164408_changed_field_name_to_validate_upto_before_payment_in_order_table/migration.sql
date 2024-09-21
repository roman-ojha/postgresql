/*
  Warnings:

  - You are about to drop the column `validate_before_payment_upto` on the `Order` table. All the data in the column will be lost.
  - Added the required column `validate_upto_before_payment` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Order" DROP COLUMN "validate_before_payment_upto",
ADD COLUMN     "validate_upto_before_payment" TIMESTAMP(3) NOT NULL;
