-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2013 年 11 月 15 日 13:57
-- 服务器版本: 5.5.8
-- PHP 版本: 5.2.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `fadcms`
--

-- --------------------------------------------------------

--
-- 表的结构 `fad_auth_assignment`
--

CREATE TABLE IF NOT EXISTS `fad_auth_assignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fad_auth_assignment`
--

INSERT INTO `fad_auth_assignment` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('Admin', '1', NULL, 'N;'),
('Editor', '1', NULL, 'N;');

-- --------------------------------------------------------

--
-- 表的结构 `fad_auth_item`
--

CREATE TABLE IF NOT EXISTS `fad_auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fad_auth_item`
--

INSERT INTO `fad_auth_item` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('Admin', 2, 'Administrator', NULL, 'N;'),
('admin.*', 1, 'Control Panel', NULL, 'N;'),
('Authenticated', 2, 'Registered user', '!Yii::app()->user->getIsGuest()', 'N;'),
('blog.*', 1, 'Blogs', NULL, 'N;'),
('catalog.*', 1, 'Catalog', NULL, 'N;'),
('comment.*', 1, 'Comments', NULL, 'N;'),
('contact.*', 1, 'Contact form and mail settings', NULL, 'N;'),
('Editor', 2, 'Redactor', NULL, 'N;'),
('gallery.*', 1, 'Gallery', NULL, 'N;'),
('menu.*', 1, 'Меню', NULL, 'N;'),
('news.*', 1, 'News', NULL, 'N;'),
('page.*', 1, 'Pages', NULL, 'N;'),
('social.*', 1, 'Social Networks', NULL, 'N;'),
('user.*', 1, 'Пользователи', NULL, 'N;');

-- --------------------------------------------------------

--
-- 表的结构 `fad_auth_item_child`
--

CREATE TABLE IF NOT EXISTS `fad_auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `fk_fad_auth_item_child_fad_auth_item_child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fad_auth_item_child`
--

INSERT INTO `fad_auth_item_child` (`parent`, `child`) VALUES
('Admin', 'admin.*'),
('Admin', 'blog.*'),
('Admin', 'catalog.*'),
('Admin', 'comment.*'),
('Admin', 'contact.*'),
('Admin', 'gallery.*'),
('Admin', 'menu.*'),
('Admin', 'news.*'),
('Admin', 'page.*'),
('Admin', 'social.*'),
('Admin', 'user.*');

-- --------------------------------------------------------

--
-- 表的结构 `fad_blog`
--

CREATE TABLE IF NOT EXISTS `fad_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(75) NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  `slug` varchar(75) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_fad_blog_slug` (`slug`),
  KEY `ix_fad_blog_type` (`type`),
  KEY `ix_fad_blog_status` (`status`),
  KEY `ix_fad_blog_create_user_id` (`create_user_id`),
  KEY `ix_fad_blog_update_user_id` (`update_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_blog`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_blog_post`
--

CREATE TABLE IF NOT EXISTS `fad_blog_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `title` varchar(75) NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(75) NOT NULL,
  `link` varchar(200) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `comment_status` tinyint(1) NOT NULL DEFAULT '1',
  `access_type` tinyint(1) NOT NULL DEFAULT '1',
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `publish_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_fad_blog_post_slug` (`slug`),
  KEY `ix_fad_blog_post_blog_id` (`blog_id`),
  KEY `ix_fad_blog_post_status` (`status`),
  KEY `ix_fad_blog_post_comment_status` (`comment_status`),
  KEY `ix_fad_blog_post_access_type` (`access_type`),
  KEY `ix_fad_blog_post_create_user_id` (`create_user_id`),
  KEY `ix_fad_blog_post_update_user_id` (`update_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_blog_post`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_blog_post_tag`
--

CREATE TABLE IF NOT EXISTS `fad_blog_post_tag` (
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `ix_fad_blog_post_tag_post_id` (`post_id`),
  KEY `ix_fad_blog_post_tag_tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fad_blog_post_tag`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_comment`
--

CREATE TABLE IF NOT EXISTS `fad_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(16) NOT NULL,
  `model_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(20) DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_fad_comment_status` (`status`),
  KEY `ix_fad_comment_create_user_id` (`create_user_id`),
  KEY `ix_fad_comment_update_user_id` (`update_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_comment`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_gallery`
--

CREATE TABLE IF NOT EXISTS `fad_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(75) NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  `slug` varchar(75) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL,
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_fad_gallery_status` (`status`),
  KEY `ix_fad_gallery_create_user_id` (`create_user_id`),
  KEY `ix_fad_gallery_update_user_id` (`update_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `fad_gallery`
--

INSERT INTO `fad_gallery` (`id`, `title`, `keywords`, `description`, `slug`, `status`, `sort_order`, `create_user_id`, `update_user_id`, `create_time`, `update_time`) VALUES
(1, 'image1', 'iamge', 'image1', 'image1', 1, 1, 1, NULL, '2013-11-15 13:43:02', '2013-11-15 13:43:02'),
(2, 'gallery2', 'gallery2', 'gallery2gallery2', 'gallery2', 1, 2, 1, NULL, '2013-11-15 13:43:56', '2013-11-15 13:43:56');

-- --------------------------------------------------------

--
-- 表的结构 `fad_gallery_photo`
--

CREATE TABLE IF NOT EXISTS `fad_gallery_photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gallery_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(75) NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  `file_name` varchar(500) NOT NULL,
  `alt` varchar(100) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL,
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_fad_gallery_photo_gallery_id` (`gallery_id`),
  KEY `ix_fad_gallery_photo_type` (`type`),
  KEY `ix_fad_gallery_photo_status` (`status`),
  KEY `ix_fad_gallery_photo_create_user_id` (`create_user_id`),
  KEY `ix_fad_gallery_photo_update_user_id` (`update_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_gallery_photo`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_menu`
--

CREATE TABLE IF NOT EXISTS `fad_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `root` int(11) NOT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `level` tinyint(4) NOT NULL,
  `code` varchar(20) NOT NULL DEFAULT '',
  `title` varchar(100) NOT NULL,
  `href` varchar(200) NOT NULL DEFAULT '',
  `type` tinyint(3) NOT NULL DEFAULT '1',
  `access` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_fad_menu_status` (`status`),
  KEY `ix_fad_menu_create_user_id` (`create_user_id`),
  KEY `ix_fad_menu_update_user_id` (`update_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `fad_menu`
--

INSERT INTO `fad_menu` (`id`, `root`, `lft`, `rgt`, `level`, `code`, `title`, `href`, `type`, `access`, `status`, `create_user_id`, `update_user_id`, `create_time`, `update_time`) VALUES
(1, 1, 1, 4, 1, 'top', 'Top menu', '', 1, NULL, 1, 1, NULL, '2013-11-14 11:11:06', '2013-11-14 11:11:06'),
(2, 1, 2, 3, 2, '', '首页', '/page/index/', 1, NULL, 1, 1, NULL, '2013-11-06 15:34:44', '2013-11-06 15:34:44'),
(3, 3, 1, 2, 1, '01', 'menu1', '', 1, '', 1, 1, NULL, '2013-11-15 13:52:01', '2013-11-15 13:52:01');

-- --------------------------------------------------------

--
-- 表的结构 `fad_migration`
--

CREATE TABLE IF NOT EXISTS `fad_migration` (
  `version` varchar(255) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  `module` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fad_migration`
--

INSERT INTO `fad_migration` (`version`, `apply_time`, `module`) VALUES
('m000000_000000_base_admin', 1383723282, 'admin'),
('m000000_000000_base_blog', 1383723286, 'blog'),
('m000000_000000_base_comment', 1383723289, 'comment'),
('m000000_000000_base_gallery', 1383723289, 'gallery'),
('m000000_000000_base_menu', 1383723283, 'menu'),
('m000000_000000_base_news', 1383723285, 'news'),
('m000000_000000_base_page', 1383723284, 'page'),
('m000000_000000_base_social', 1383723292, 'social'),
('m000000_000000_base_user', 1383723280, 'user'),
('m130121_130000_user', 1383723281, 'user'),
('m130121_130001_admin', 1383723283, 'admin'),
('m130121_130002_menu', 1383723284, 'menu'),
('m130121_130003_page', 1383723285, 'page'),
('m130121_130004_news', 1383723286, 'news'),
('m130121_130005_gallery', 1383723292, 'gallery'),
('m130121_130006_blog', 1383723288, 'blog'),
('m130121_130007_comment', 1383723289, 'comment'),
('m130121_130008_social', 1383723292, 'social'),
('m130816_104840_addType', 1383723285, 'page'),
('m131019_111347_addTypeArticle', 1383723285, 'page');

-- --------------------------------------------------------

--
-- 表的结构 `fad_news`
--

CREATE TABLE IF NOT EXISTS `fad_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `title` varchar(75) NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `description` varchar(200) NOT NULL,
  `content_short` varchar(400) NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(75) NOT NULL,
  `image` varchar(300) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_protected` tinyint(1) NOT NULL DEFAULT '0',
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_fad_news_slug` (`slug`),
  KEY `ix_fad_news_status` (`status`),
  KEY `ix_fad_news_is_protected` (`is_protected`),
  KEY `ix_fad_news_create_user_id` (`create_user_id`),
  KEY `ix_fad_news_update_user_id` (`update_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `fad_news`
--

INSERT INTO `fad_news` (`id`, `date`, `title`, `keywords`, `description`, `content_short`, `content`, `slug`, `image`, `status`, `is_protected`, `create_user_id`, `update_user_id`, `create_time`, `update_time`) VALUES
(1, '2013-11-14', 'This is the first news', 'news', 'news', '<p>This is the first news</p>', '<p><strong>This is the first news!</strong></p>\r\n<p>&nbsp;</p>', 'this-is-the-first-news', '', 1, 0, 1, NULL, '2013-11-14 13:54:52', '2013-11-14 13:54:52'),
(2, '2013-11-14', 'The second', '', '', '<p>the-second</p>', '<div class="para">User-agent: * 这里的*代表的所有的搜索引擎种类，*是一个<a href="http://baike.baidu.com/view/451.htm" target="_blank">通配符</a></div>\r\n<div class="para">Disallow: /admin/ 这里定义是禁止爬寻<a href="http://baike.baidu.com/view/11220.htm" target="_blank">admin</a>目录下面的目录</div>\r\n<div class="para">Disallow: /require/ 这里定义是禁止爬寻require目录下面的<a href="http://baike.baidu.com/view/637.htm" target="_blank">目录</a></div>\r\n<div class="para">Disallow: /ABC/ 这里定义是禁止爬寻ABC目录下面的目录</div>\r\n<div class="para">Disallow: /cgi-bin/*.htm 禁止访问/cgi-bin/目录下的所有以".htm"为后缀的URL(包含<a href="http://baike.baidu.com/view/1765050.htm" target="_blank">子目录</a>)。</div>\r\n<div class="para">Disallow: /*?* 禁止访问网站中所有包含问号 (?) 的网址</div>\r\n<div class="para">Disallow: /.jpg$ 禁止抓取网页所有的.jpg格式的<a href="http://baike.baidu.com/view/19159.htm" target="_blank">图片</a></div>\r\n<div class="para">Disallow:/ab/adc.html 禁止爬取ab文件夹下面的adc.html文件。</div>\r\n<div class="para">Allow: /cgi-bin/　这里定义是允许爬寻cgi-bin目录下面的目录</div>\r\n<div class="para">Allow: /tmp 这里定义是允许爬寻tmp的整个目录</div>\r\n<div class="para">Allow: .htm$ 仅允许访问以".htm"为后缀的URL。</div>\r\n<div class="para">Allow: .gif$ 允许抓取网页和gif格式图片</div>\r\n<div class="para">&nbsp;</div>', 'the-second', '', 1, 0, 1, NULL, '2013-11-14 13:56:39', '2013-11-14 13:56:39');

-- --------------------------------------------------------

--
-- 表的结构 `fad_page`
--

CREATE TABLE IF NOT EXISTS `fad_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `level` tinyint(3) NOT NULL DEFAULT '1',
  `name` varchar(50) NOT NULL,
  `title` varchar(75) NOT NULL,
  `keywords` varchar(200) NOT NULL DEFAULT '',
  `description` varchar(200) NOT NULL,
  `annotation` varchar(400) NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(75) NOT NULL,
  `image` varchar(300) NOT NULL,
  `rich_editor` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `type` tinyint(4) DEFAULT NULL,
  `is_protected` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int(11) DEFAULT NULL,
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_fad_page_slug` (`slug`),
  KEY `ix_fad_page_parent_id` (`parent_id`),
  KEY `ix_fad_page_status` (`status`),
  KEY `ix_fad_page_is_protected` (`is_protected`),
  KEY `ix_fad_page_sort_order` (`sort_order`),
  KEY `ix_fad_page_create_user_id` (`create_user_id`),
  KEY `ix_fad_page_update_user_id` (`update_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `fad_page`
--

INSERT INTO `fad_page` (`id`, `parent_id`, `level`, `name`, `title`, `keywords`, `description`, `annotation`, `content`, `slug`, `image`, `rich_editor`, `status`, `type`, `is_protected`, `sort_order`, `create_user_id`, `update_user_id`, `create_time`, `update_time`) VALUES
(1, NULL, 1, 'Home (Main page)', 'Title page (Page title)', '', 'Yii Fad Cms', '', '<h3> Home Page </ h3> <p> home page. Go to page management to change the text. </ P> <p> Powered by <a href="http://yiifad.ru/" rel="external"> Yii Fad CMS </ a>. </ P>', 'index', '', 1, 1, NULL, 0, 1, 1, NULL, '2013-11-13 15:44:04', '2013-11-13 15:44:04');

-- --------------------------------------------------------

--
-- 表的结构 `fad_settings`
--

CREATE TABLE IF NOT EXISTS `fad_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` varchar(32) NOT NULL,
  `key` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  `create_user_id` int(11) NOT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_fad_settings_module_id` (`module_id`),
  KEY `ix_fad_settings_create_user_id` (`create_user_id`),
  KEY `ix_fad_settings_update_user_id` (`update_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_settings`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_tag`
--

CREATE TABLE IF NOT EXISTS `fad_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_tag_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_tag`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_user`
--

CREATE TABLE IF NOT EXISTS `fad_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(150) DEFAULT NULL,
  `lastname` varchar(150) DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  `sex` tinyint(1) NOT NULL DEFAULT '0',
  `birth_date` date DEFAULT NULL,
  `country` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `access_level` tinyint(1) NOT NULL DEFAULT '0',
  `last_visit` datetime DEFAULT NULL,
  `registration_date` datetime NOT NULL,
  `registration_ip` varchar(20) NOT NULL,
  `activation_ip` varchar(20) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `use_gravatar` tinyint(1) NOT NULL DEFAULT '0',
  `activate_key` varchar(32) NOT NULL,
  `email_confirm` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_fad_user_username` (`username`),
  UNIQUE KEY `ux_fad_user_email` (`email`),
  KEY `ix_fad_user_status` (`status`),
  KEY `ix_fad_user_email_confirm` (`email_confirm`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `fad_user`
--

INSERT INTO `fad_user` (`id`, `firstname`, `lastname`, `username`, `sex`, `birth_date`, `country`, `city`, `phone`, `email`, `password`, `salt`, `status`, `access_level`, `last_visit`, `registration_date`, `registration_ip`, `activation_ip`, `photo`, `avatar`, `use_gravatar`, `activate_key`, `email_confirm`, `create_time`, `update_time`) VALUES
(1, 'admin', NULL, 'admin', 0, NULL, 'Russia', '', '', '80234043@qq.com', 'bc850fb8539ac21da5b30195214f9d09', '3ce761a7e765bdeba8cbf0f249b2ca14', 1, 1, '2013-11-15 13:53:17', '2013-11-06 15:34:41', '127.0.0.1', '127.0.0.1', NULL, NULL, 0, 'c4c9b055e8fbc7f0e9c9d96bb58b9d17', 1, '2013-11-06 15:34:41', '2013-11-15 13:53:17'),
(2, 'richard', 'ma', 'richard', 0, NULL, '', '', '', 'richardma@antec.com', 'e10adc3949ba59abbe56e057f20f883e', '6aa5d3be5c06f1f6983db1eb59699370', 1, 0, NULL, '2013-11-15 13:34:55', '127.0.0.1', '127.0.0.1', NULL, NULL, 0, '693518e24da04dbd1419d7e40ac01932', 1, '2013-11-15 13:34:55', '2013-11-15 13:34:55');

-- --------------------------------------------------------

--
-- 表的结构 `fad_user_blog`
--

CREATE TABLE IF NOT EXISTS `fad_user_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `role` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `note` varchar(255) NOT NULL DEFAULT '',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_fad_user_blog_user_id_blog_id` (`user_id`,`blog_id`),
  KEY `ix_fad_user_blog_blog_user_id` (`user_id`),
  KEY `ix_fad_user_blog_blog_blog_id` (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `fad_user_blog`
--


-- --------------------------------------------------------

--
-- 表的结构 `fad_user_social`
--

CREATE TABLE IF NOT EXISTS `fad_user_social` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service` varchar(64) NOT NULL,
  `access_token` varchar(255) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  UNIQUE KEY `ux_fad_user_social_id` (`id`),
  KEY `ix_fad_user_social_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fad_user_social`
--


--
-- 限制导出的表
--

--
-- 限制表 `fad_auth_assignment`
--
ALTER TABLE `fad_auth_assignment`
  ADD CONSTRAINT `fk_fad_auth_assignment_fad_auth_item_name` FOREIGN KEY (`itemname`) REFERENCES `fad_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `fad_auth_item_child`
--
ALTER TABLE `fad_auth_item_child`
  ADD CONSTRAINT `fk_fad_auth_item_child_fad_auth_item_child` FOREIGN KEY (`child`) REFERENCES `fad_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fad_auth_item_child_fad_auth_item_parent` FOREIGN KEY (`parent`) REFERENCES `fad_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `fad_blog`
--
ALTER TABLE `fad_blog`
  ADD CONSTRAINT `fk_fad_blog_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_blog_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `fad_blog_post`
--
ALTER TABLE `fad_blog_post`
  ADD CONSTRAINT `fk_fad_blog_post_fad_blog_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `fad_blog` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_blog_post_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_blog_post_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON UPDATE NO ACTION;

--
-- 限制表 `fad_blog_post_tag`
--
ALTER TABLE `fad_blog_post_tag`
  ADD CONSTRAINT `fk_fad_blog_post_tag_fad_blog_post_post_id` FOREIGN KEY (`post_id`) REFERENCES `fad_blog_post` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_blog_post_tag_fad_tag_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `fad_tag` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `fad_comment`
--
ALTER TABLE `fad_comment`
  ADD CONSTRAINT `fk_fad_comment_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_comment_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `fad_gallery`
--
ALTER TABLE `fad_gallery`
  ADD CONSTRAINT `fk_fad_gallery_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_gallery_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `fad_gallery_photo`
--
ALTER TABLE `fad_gallery_photo`
  ADD CONSTRAINT `fk_fad_gallery_photo_fad_gallery_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `fad_gallery` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_gallery_photo_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_gallery_photo_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `fad_menu`
--
ALTER TABLE `fad_menu`
  ADD CONSTRAINT `fk_fad_menu_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_menu_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `fad_news`
--
ALTER TABLE `fad_news`
  ADD CONSTRAINT `fk_fad_news_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_news_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `fad_page`
--
ALTER TABLE `fad_page`
  ADD CONSTRAINT `fk_fad_page_fad_page_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `fad_page` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_page_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_page_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `fad_settings`
--
ALTER TABLE `fad_settings`
  ADD CONSTRAINT `fk_fad_settings_fad_user_create_user_id` FOREIGN KEY (`create_user_id`) REFERENCES `fad_user` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_settings_fad_user_update_user_id` FOREIGN KEY (`update_user_id`) REFERENCES `fad_user` (`id`) ON UPDATE NO ACTION;

--
-- 限制表 `fad_user_blog`
--
ALTER TABLE `fad_user_blog`
  ADD CONSTRAINT `fk_fad_user_blog_fad_blog_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `fad_blog` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fad_user_blog_fad_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- 限制表 `fad_user_social`
--
ALTER TABLE `fad_user_social`
  ADD CONSTRAINT `fk_fad_user_social_fad_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `fad_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
