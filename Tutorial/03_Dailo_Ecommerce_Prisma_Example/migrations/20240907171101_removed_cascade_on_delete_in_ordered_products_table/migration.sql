-- DropForeignKey
ALTER TABLE "OrderedProducts" DROP CONSTRAINT "OrderedProducts_order_id_fkey";

-- DropForeignKey
ALTER TABLE "OrderedProducts" DROP CONSTRAINT "OrderedProducts_product_id_fkey";

-- AddForeignKey
ALTER TABLE "OrderedProducts" ADD CONSTRAINT "OrderedProducts_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderedProducts" ADD CONSTRAINT "OrderedProducts_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
