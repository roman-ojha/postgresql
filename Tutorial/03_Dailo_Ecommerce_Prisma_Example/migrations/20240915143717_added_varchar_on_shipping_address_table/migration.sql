/*
  Warnings:

  - You are about to alter the column `first_name` on the `shipping_addresses` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(50)`.
  - You are about to alter the column `last_name` on the `shipping_addresses` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(50)`.
  - You are about to alter the column `country` on the `shipping_addresses` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(80)`.
  - You are about to alter the column `phone_no` on the `shipping_addresses` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(20)`.

*/
-- AlterTable
ALTER TABLE "categories" ALTER COLUMN "picture_bucket_name" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "shipping_addresses" ALTER COLUMN "first_name" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "last_name" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "country" SET DATA TYPE VARCHAR(80),
ALTER COLUMN "phone_no" SET DATA TYPE VARCHAR(20);
