/*
  Warnings:

  - You are about to drop the column `is_active` on the `Order` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Order_user_id_is_active_idx";

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "is_active";

-- CreateIndex
CREATE INDEX "Order_user_id_status_idx" ON "Order"("user_id", "status");
