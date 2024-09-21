/*
  Warnings:

  - You are about to drop the column `appartment_or_suite_or_unit` on the `ShippingAddress` table. All the data in the column will be lost.
  - Added the required column `apartment_or_suite_or_unit` to the `ShippingAddress` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `ShippingAddress` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ShippingAddress" DROP COLUMN "appartment_or_suite_or_unit",
ADD COLUMN     "apartment_or_suite_or_unit" TEXT NOT NULL,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE INDEX "ShippingAddress_user_id_idx" ON "ShippingAddress"("user_id");
