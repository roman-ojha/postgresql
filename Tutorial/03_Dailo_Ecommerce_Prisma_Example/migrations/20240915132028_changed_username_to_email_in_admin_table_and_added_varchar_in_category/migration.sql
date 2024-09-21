/*
  Warnings:

  - You are about to drop the column `username` on the `admins` table. All the data in the column will be lost.
  - You are about to alter the column `name` on the `categories` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `picture_bucket_name` on the `categories` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(25)`.
  - A unique constraint covering the columns `[email]` on the table `admins` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `admins` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "admins_username_idx";

-- DropIndex
DROP INDEX "admins_username_key";

-- AlterTable
ALTER TABLE "admins" DROP COLUMN "username",
ADD COLUMN     "email" VARCHAR(50) NOT NULL;

-- AlterTable
ALTER TABLE "categories" ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "picture_bucket_name" SET DATA TYPE VARCHAR(25);

-- CreateIndex
CREATE UNIQUE INDEX "admins_email_key" ON "admins"("email");

-- CreateIndex
CREATE INDEX "admins_email_idx" ON "admins"("email");
