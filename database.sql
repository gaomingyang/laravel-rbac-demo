/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80403 (8.4.3)
 Source Host           : localhost:3306
 Source Schema         : lara10

 Target Server Type    : MySQL
 Target Server Version : 80403 (8.4.3)
 File Encoding         : 65001

 Date: 10/02/2025 00:28:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_menu_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu_permissions`;
CREATE TABLE `admin_menu_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int unsigned NOT NULL,
  `permission_id` int unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_menu` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of admin_menu_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu_permissions` (`id`, `menu_id`, `permission_id`, `created_at`, `updated_at`) VALUES (1, 1, 1, '2025-02-07 19:40:17', NULL);
INSERT INTO `admin_menu_permissions` (`id`, `menu_id`, `permission_id`, `created_at`, `updated_at`) VALUES (2, 1, 2, '2025-02-07 19:40:17', NULL);
INSERT INTO `admin_menu_permissions` (`id`, `menu_id`, `permission_id`, `created_at`, `updated_at`) VALUES (3, 3, 3, '2025-02-09 23:07:40', '2025-02-09 23:07:45');
COMMIT;

-- ----------------------------
-- Table structure for admin_menus
-- ----------------------------
DROP TABLE IF EXISTS `admin_menus`;
CREATE TABLE `admin_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0=禁用，1=启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_menus
-- ----------------------------
BEGIN;
INSERT INTO `admin_menus` (`id`, `parent_id`, `name`, `path`, `icon`, `sort`, `status`, `created_at`, `updated_at`) VALUES (1, 0, '商品管理', NULL, NULL, 0, 1, NULL, NULL);
INSERT INTO `admin_menus` (`id`, `parent_id`, `name`, `path`, `icon`, `sort`, `status`, `created_at`, `updated_at`) VALUES (2, 0, '订单管理', NULL, NULL, 0, 1, NULL, NULL);
INSERT INTO `admin_menus` (`id`, `parent_id`, `name`, `path`, `icon`, `sort`, `status`, `created_at`, `updated_at`) VALUES (3, 1, '修改商品', NULL, NULL, 0, 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '权限名称',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '操作 (method@path)',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '权限描述',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_action` (`action`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='权限表，所有接口路由';

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_permissions` (`id`, `name`, `action`, `description`, `created_at`, `updated_at`) VALUES (1, NULL, 'get@goods', '查询商品', '2025-02-07 19:35:12', '2025-02-09 23:51:33');
INSERT INTO `admin_permissions` (`id`, `name`, `action`, `description`, `created_at`, `updated_at`) VALUES (2, NULL, 'post@goods', '创建商品', '2025-02-07 19:37:02', '2025-02-09 23:51:36');
INSERT INTO `admin_permissions` (`id`, `name`, `action`, `description`, `created_at`, `updated_at`) VALUES (3, NULL, 'put@goods/*', '修改商品', '2025-02-07 19:38:47', '2025-02-09 23:51:39');
COMMIT;

-- ----------------------------
-- Table structure for admin_role_menus
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menus`;
CREATE TABLE `admin_role_menus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `menu_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `udpated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色菜单表';

-- ----------------------------
-- Records of admin_role_menus
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_menus` (`id`, `role_id`, `menu_id`, `created_at`, `udpated_at`) VALUES (1, 1, 1, '2025-02-10 00:18:45', NULL);
INSERT INTO `admin_role_menus` (`id`, `role_id`, `menu_id`, `created_at`, `udpated_at`) VALUES (2, 1, 2, '2025-02-10 00:18:45', NULL);
INSERT INTO `admin_role_menus` (`id`, `role_id`, `menu_id`, `created_at`, `udpated_at`) VALUES (3, 1, 3, '2025-02-10 00:18:45', NULL);
INSERT INTO `admin_role_menus` (`id`, `role_id`, `menu_id`, `created_at`, `udpated_at`) VALUES (4, 2, 1, '2025-02-10 00:18:45', NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`role_id`,`permission_id`) USING BTREE,
  KEY `idx_user_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户接口权限表';

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_permissions` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES (1, 1, 1, '2025-02-10 00:25:59', NULL);
INSERT INTO `admin_role_permissions` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES (2, 1, 2, '2025-02-10 00:25:59', NULL);
INSERT INTO `admin_role_permissions` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES (3, 1, 3, '2025-02-10 00:25:59', NULL);
INSERT INTO `admin_role_permissions` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES (4, 2, 1, '2025-02-10 00:25:59', NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_role_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
BEGIN;
INSERT INTO `admin_roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (1, 'goods_manager', '', '2025-02-09 23:10:31', NULL);
INSERT INTO `admin_roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES (2, 'goods_viewer', '', '2025-02-09 23:10:42', NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_roles`;
CREATE TABLE `admin_user_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_user_role` (`user_id`,`role_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户角色表';

-- ----------------------------
-- Records of admin_user_roles
-- ----------------------------
BEGIN;
INSERT INTO `admin_user_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES (1, 1, 1, '2025-02-10 00:21:48', NULL);
INSERT INTO `admin_user_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES (2, 2, 2, '2025-02-10 00:21:48', NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint unsigned NOT NULL DEFAULT '2' COMMENT '1admin 2normal',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT '1' COMMENT '状态：0=禁用，1=启用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- ----------------------------
-- Records of admin_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_users` (`id`, `type`, `username`, `password`, `name`, `email`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 2, 'user1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user1@test.com', 1, '2025-02-09 23:21:23', '2025-02-09 23:35:34', NULL);
INSERT INTO `admin_users` (`id`, `type`, `username`, `password`, `name`, `email`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 2, 'user2', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'user2@test.com', 1, '2025-02-09 23:21:31', '2025-02-09 23:54:01', NULL);
INSERT INTO `admin_users` (`id`, `type`, `username`, `password`, `name`, `email`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '超级管理员', 'admin@example.com', 1, '2025-02-09 23:28:04', '2025-02-10 00:23:56', NULL);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (2, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (4, '2019_12_14_000001_create_personal_access_tokens_table', 1);
COMMIT;

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES (1, 'user1', 'user1@test.com', NULL, '$2y$12$Go2uoVvfihCRYI2STQflmuqDFfNGHVsh11SVpM9HDvy8Y5WbTkNTS', 'ZDXAOrrBoIThYXNALYpsMrA6kwIjuoqJB1tVCbDZ1pqLzIgx1iwZHPo0CALP', '2025-02-08 03:44:54', '2025-02-08 03:44:54');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES (2, 'user2', 'user2@test.com', NULL, '$2y$12$Go2uoVvfihCRYI2STQflmuqDFfNGHVsh11SVpM9HDvy8Y5WbTkNTS', NULL, '2025-02-08 03:47:53', '2025-02-08 03:47:53');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
