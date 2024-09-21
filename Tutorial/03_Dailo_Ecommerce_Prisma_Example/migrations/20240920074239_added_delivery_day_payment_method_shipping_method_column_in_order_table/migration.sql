/*
  Warnings:

  - The values [pending,processing,cancelled,delivered] on the enum `OrderStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- CreateEnum
CREATE TYPE "DeliveryDay" AS ENUM ('SUNDAY', 'SATURDAY');

-- AlterEnum
BEGIN;
CREATE TYPE "OrderStatus_new" AS ENUM ('PENDING', 'PROCESSING', 'CANCELLED', 'COMPLETED');
ALTER TABLE "orders" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "orders" ALTER COLUMN "status" TYPE "OrderStatus_new" USING ("status"::text::"OrderStatus_new");
ALTER TYPE "OrderStatus" RENAME TO "OrderStatus_old";
ALTER TYPE "OrderStatus_new" RENAME TO "OrderStatus";
DROP TYPE "OrderStatus_old";
ALTER TABLE "orders" ALTER COLUMN "status" SET DEFAULT 'PENDING';
COMMIT;

-- AlterTable
ALTER TABLE "orders" ADD COLUMN     "delivery_day" "DeliveryDay",
ADD COLUMN     "payment_method" VARCHAR(20) NOT NULL DEFAULT 'MobilePay',
ADD COLUMN     "shipping_method" TEXT NOT NULL DEFAULT 'ParkingPlace',
ALTER COLUMN "status" SET DEFAULT 'PENDING';
