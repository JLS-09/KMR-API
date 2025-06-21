/*
  Warnings:

  - You are about to drop the column `replacementIdentifier` on the `ReplacedBy` table. All the data in the column will be lost.
  - Added the required column `name` to the `ReplacedBy` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `ReplacedBy` DROP FOREIGN KEY `ReplacedBy_replacementIdentifier_fkey`;

-- DropIndex
DROP INDEX `ReplacedBy_replacementIdentifier_key` ON `ReplacedBy`;

-- AlterTable
ALTER TABLE `ReplacedBy` DROP COLUMN `replacementIdentifier`,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;
