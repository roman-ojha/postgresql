/*
  Warnings:

  - Added the required column `validate_before_payment_upto` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Order" ADD COLUMN     "validate_before_payment_upto" TIMESTAMP(3) NOT NULL;
