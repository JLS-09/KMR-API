-- CreateTable
CREATE TABLE `Mod` (
    `identifier` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `abstract` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `ksp_version` VARCHAR(191) NULL DEFAULT 'any',
    `ksp_version_min` VARCHAR(191) NULL,
    `ksp_version_max` VARCHAR(191) NULL,
    `ksp_version_strict` BOOLEAN NULL DEFAULT false,
    `tags` JSON NULL,
    `localizations` JSON NULL,

    UNIQUE INDEX `Mod_identifier_key`(`identifier`),
    PRIMARY KEY (`identifier`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Version` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `spec_version` INTEGER NOT NULL,
    `download` VARCHAR(191) NOT NULL,
    `license` VARCHAR(191) NOT NULL,
    `version` VARCHAR(191) NOT NULL,
    `epoch` INTEGER NOT NULL DEFAULT 0,
    `mod_version` VARCHAR(191) NOT NULL,
    `comment` VARCHAR(191) NULL,
    `download_size` INTEGER NULL,
    `download_content_type` VARCHAR(191) NULL,
    `install_size` INTEGER NULL,
    `release_date` DATETIME(3) NULL,
    `release_status` VARCHAR(191) NULL,
    `kind` VARCHAR(191) NULL,
    `provides` JSON NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Author` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Install` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `file` VARCHAR(191) NULL,
    `find` VARCHAR(191) NULL,
    `find_regexp` VARCHAR(191) NULL,
    `install_to` VARCHAR(191) NOT NULL,
    `as` VARCHAR(191) NULL,
    `filter` VARCHAR(191) NULL,
    `filter_regexp` VARCHAR(191) NULL,
    `include_only` VARCHAR(191) NULL,
    `include_only_regexp` VARCHAR(191) NULL,
    `find_matches_files` VARCHAR(191) NULL,
    `versionId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Download_hash` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sha1` VARCHAR(191) NULL,
    `sha256` VARCHAR(191) NULL,
    `versionId` INTEGER NOT NULL,

    UNIQUE INDEX `Download_hash_versionId_key`(`versionId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Relationship` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(191) NOT NULL,
    `choice_help_text` VARCHAR(191) NULL,
    `suppress_recommendations` BOOLEAN NULL DEFAULT false,
    `modIdentifier` VARCHAR(191) NOT NULL,
    `targetVersionId` INTEGER NULL,
    `anyOfGroupId` INTEGER NULL,
    `min_version` VARCHAR(191) NULL,
    `max_version` VARCHAR(191) NULL,
    `version` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AnyOfGroup` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReplacedBy` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `modIdentifier` VARCHAR(191) NOT NULL,
    `replacementIdentifier` VARCHAR(191) NOT NULL,
    `version` VARCHAR(191) NULL,
    `min_version` VARCHAR(191) NULL,

    UNIQUE INDEX `ReplacedBy_modIdentifier_key`(`modIdentifier`),
    UNIQUE INDEX `ReplacedBy_replacementIdentifier_key`(`replacementIdentifier`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Resources` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `homepage` VARCHAR(191) NULL,
    `bugtracker` VARCHAR(191) NULL,
    `discussions` VARCHAR(191) NULL,
    `license` VARCHAR(191) NULL,
    `repository` VARCHAR(191) NULL,
    `ci` VARCHAR(191) NULL,
    `spacedock` VARCHAR(191) NULL,
    `curse` VARCHAR(191) NULL,
    `manual` VARCHAR(191) NULL,
    `metanetkan` VARCHAR(191) NULL,
    `remote_avc` VARCHAR(191) NULL,
    `remote_swinfo` VARCHAR(191) NULL,
    `store` VARCHAR(191) NULL,
    `steamstore` VARCHAR(191) NULL,
    `versionId` INTEGER NOT NULL,

    UNIQUE INDEX `Resources_versionId_key`(`versionId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_AuthorToMod` (
    `A` INTEGER NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_AuthorToMod_AB_unique`(`A`, `B`),
    INDEX `_AuthorToMod_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Install` ADD CONSTRAINT `Install_versionId_fkey` FOREIGN KEY (`versionId`) REFERENCES `Version`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Download_hash` ADD CONSTRAINT `Download_hash_versionId_fkey` FOREIGN KEY (`versionId`) REFERENCES `Version`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Relationship` ADD CONSTRAINT `Relationship_modIdentifier_fkey` FOREIGN KEY (`modIdentifier`) REFERENCES `Mod`(`identifier`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Relationship` ADD CONSTRAINT `Relationship_targetVersionId_fkey` FOREIGN KEY (`targetVersionId`) REFERENCES `Version`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Relationship` ADD CONSTRAINT `Relationship_anyOfGroupId_fkey` FOREIGN KEY (`anyOfGroupId`) REFERENCES `AnyOfGroup`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReplacedBy` ADD CONSTRAINT `ReplacedBy_modIdentifier_fkey` FOREIGN KEY (`modIdentifier`) REFERENCES `Mod`(`identifier`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReplacedBy` ADD CONSTRAINT `ReplacedBy_replacementIdentifier_fkey` FOREIGN KEY (`replacementIdentifier`) REFERENCES `Mod`(`identifier`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Resources` ADD CONSTRAINT `Resources_versionId_fkey` FOREIGN KEY (`versionId`) REFERENCES `Version`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_AuthorToMod` ADD CONSTRAINT `_AuthorToMod_A_fkey` FOREIGN KEY (`A`) REFERENCES `Author`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_AuthorToMod` ADD CONSTRAINT `_AuthorToMod_B_fkey` FOREIGN KEY (`B`) REFERENCES `Mod`(`identifier`) ON DELETE CASCADE ON UPDATE CASCADE;
