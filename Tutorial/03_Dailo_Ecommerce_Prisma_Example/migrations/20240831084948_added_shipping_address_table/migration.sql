-- CreateTable
CREATE TABLE "ShippingAddress" (
    "id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "country" TEXT NOT NULL DEFAULT 'Denmark',
    "house_number_and_street_name" TEXT NOT NULL,
    "appartment_or_suite_or_unit" TEXT NOT NULL,
    "town_or_city_name" TEXT NOT NULL,
    "phone_no" TEXT NOT NULL,

    CONSTRAINT "ShippingAddress_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ShippingAddress" ADD CONSTRAINT "ShippingAddress_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
