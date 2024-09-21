-- CreateTable
CREATE TABLE "Rate" (
    "id" SERIAL NOT NULL,
    "star" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "product_id" INTEGER NOT NULL,

    CONSTRAINT "Rate_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Rate_product_id_idx" ON "Rate"("product_id");

-- AddForeignKey
ALTER TABLE "Rate" ADD CONSTRAINT "Rate_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
