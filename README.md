## Laravel rbac demo

### deploy

```bash
# copy .env.example to .env
cp .env.example .env

# modify .env to add database config

# install dependencies
composer install

# generate jwt secret
php artisan jwt:secret

# import database.sql to your database

# run server
php artisan serve

```

demo 账号：
user1@test.com Us!12345  
user2@test.com Us!12345

菜单 admin_menus  
1.商品管理  
 3.商品修改  
2.订单管理

权限：admin_permissions  
1.查询商品 get@goods  
2.创建商品 post@goods  
3.修改商品 put@goods

菜单权限表 admin_menu_permissions
1-1
1-2
3-3

用户表 users 1.用户名 user1 2.用户名 user2

角色表 admin_roles
1.goods_manager
2.goods_viewer

用户角色表 admin_user_roles
1-1
2-2

角色菜单表 admin_role_menus
1-1
1-2
1-3
2-1

角色权限表 admin_role_permissions
1-1
1-2
1-3
2-1
