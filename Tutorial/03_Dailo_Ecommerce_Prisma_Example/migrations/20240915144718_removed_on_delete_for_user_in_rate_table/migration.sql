-- DropForeignKey
ALTER TABLE "rates" DROP CONSTRAINT "rates_user_id_fkey";

-- AddForeignKey
ALTER TABLE "rates" ADD CONSTRAINT "rates_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
