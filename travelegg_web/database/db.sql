/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.28-MariaDB : Database - flutter_smarttravalogue
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`flutter_smarttravalogue` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `flutter_smarttravalogue`;

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `feedback` */

insert  into `feedback`(`feedback_id`,`login_id`,`title`,`description`,`date_time`) values 
(19,6,'hu','ggg','2024-01-16 22:43:27'),
(20,6,'hu','ggg','2024-01-16 22:43:33'),
(21,6,'yy','hh','2024-01-16 22:50:27'),
(22,6,'vvv','frf','2024-01-16 22:50:33'),
(23,6,'xx','ii','2024-01-16 22:50:43'),
(24,6,'fggg','tg','2024-01-16 23:07:58'),
(25,6,'yuu','jjj','2024-01-17 13:39:27');

/*Table structure for table `history` */

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_type_id` int(11) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `history` */

insert  into `history`(`history_id`,`user_id`,`place_type_id`,`date`) values 
(1,4,3,'12/12/2022'),
(2,4,3,'2022-11-30'),
(3,4,2,'2022-11-30'),
(4,4,2,'2022-11-30'),
(5,4,2,'2022-11-30'),
(6,4,3,'2022-11-30'),
(7,4,2,'2022-11-30'),
(8,5,2,'2023-12-12'),
(9,5,2,'2023-12-12'),
(10,5,2,'2023-12-12'),
(11,5,2,'2023-12-12'),
(12,5,2,'2023-12-12');

/*Table structure for table `hotels` */

DROP TABLE IF EXISTS `hotels`;

CREATE TABLE `hotels` (
  `hotel_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_name` varchar(100) DEFAULT NULL,
  `about` varchar(100) DEFAULT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `photo` varchar(500) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `hotels` */

insert  into `hotels`(`hotel_id`,`hotel_name`,`about`,`latitude`,`longitude`,`phone`,`email`,`photo`,`place`) values 
(2,'Taj','heeeee','9.984045118872803','76.28057709400555','9061442266','aru487@gmail.com','static/uploads/3c98a49e-a5b5-4731-b37c-214395def09awp8672430.jpg','kochi'),
(3,'sreethar','dcsdcdscdsgvcsdjcsd gcjds','9.967425897280174','76.28348250262452','7894561230','skj@gmail.com','static/uploads/96f6c6f0-cfba-4f19-8134-f0138ca6a7b9hitel1.jpg','asxjsdchb'),
(4,'santhan','dcsdcdscdsgvcsdjcsd gcjds','9.967328978273532','76.30717277526855','7894561230','skj@gmail.com','static/uploads/be3c89c1-b179-4bb9-b0e8-d497c90c702chitel3.jpg','asxjsdchb'),
(5,'abhi','dcsdcdscdsgvcsdjcsd gcjds','9.967328978273532','76.30717277526855','7894561230','skj@gmail.com','static/uploads/572e8d74-506a-4ea0-9513-322ff5b31127hotel4.jpg','asxjsdchb'),
(6,'hari','xxxxxxxxxxxxxxxxx','9.967328978273532','76.30717277526855','7894561230','skj@gmail.com','static/uploads/6ce5546e-36da-4176-8810-554ac5e758e0hotel2.jpg','asm,xasgvkcsdjkcd');

/*Table structure for table `interests` */

DROP TABLE IF EXISTS `interests`;

CREATE TABLE `interests` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `interests` */

insert  into `interests`(`interest_id`,`user_id`,`place_id`) values 
(19,6,12),
(35,6,11),
(36,6,14);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usertype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`usertype`) values 
(1,'admin','admin','admin'),
(2,'ss','ss','user'),
(5,'f','f','user'),
(6,'user','user','user'),
(7,'ann','users','user'),
(8,'ar','ar','user'),
(9,'myu','myu','user');

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `notifications` */

insert  into `notifications`(`notification_id`,`title`,`description`,`date_time`) values 
(9,'hlllllll',' haaaaaaa','2023-12-09 16:42:29'),
(10,'samsung','a57','2023-12-09 17:14:39');

/*Table structure for table `packages` */

DROP TABLE IF EXISTS `packages`;

CREATE TABLE `packages` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `amount` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `packages` */

insert  into `packages`(`package_id`,`hotel_id`,`title`,`description`,`amount`) values 
(1,1,' rew  ',' hvfdcx ','12'),
(6,2,'One day','Enjoyyyy......','3200'),
(7,3,'s,.mcdscydsh','xmcbdhcghds','5000'),
(8,4,'sajkcxasccdhb','kjnchdsckhdschds','6000'),
(9,5,'sckjss,cjsgdhc','skchdsycgdtyscs','7000'),
(10,6,'xxxxxxxxxxxxx','xxxxxxxxxxxxxxxxxxxxxx','150000'),
(11,6,'uuuuuuuuuuu','s;lckxsdiuchdscsdu,ch','9000'),
(12,5,'yyyyyyyy','yyyyyuuuuuuuuuuu','8000');

/*Table structure for table `place_type` */

DROP TABLE IF EXISTS `place_type`;

CREATE TABLE `place_type` (
  `place_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`place_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `place_type` */

insert  into `place_type`(`place_type_id`,`type_name`) values 
(2,'Parks'),
(3,'police station');

/*Table structure for table `places` */

DROP TABLE IF EXISTS `places`;

CREATE TABLE `places` (
  `place_id` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `place_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `places` */

insert  into `places`(`place_id`,`latitude`,`longitude`,`type_id`,`title`,`description`,`place_image`) values 
(5,'9.986348845905287','76.27498626708984',3,'sasdxdqs','sxwssw','static/uploads/8c87545e-8599-4b22-a9b0-f2b4c6fa4338delhi-pl.jpg'),
(7,'9.966314554146333','76.28657341003418',2,'SUBHASH','heeee heeee','static/uploads/8c87545e-8599-4b22-a9b0-f2b4c6fa4338delhi-pl.jpg'),
(8,'9.870629943412304','76.37808983338826',3,'pala','heee heeee','static/uploads/8c87545e-8599-4b22-a9b0-f2b4c6fa4338delhi-pl.jpg'),
(9,'9.976318645792988','76.28627970814705',3,'Riss','Technologiess','static/uploads/8c87545e-8599-4b22-a9b0-f2b4c6fa4338delhi-pl.jpg'),
(10,'9.976318645792988','76.28627970814705',3,'alarammmmmmm','adikkatteeeee','static/uploads/8c87545e-8599-4b22-a9b0-f2b4c6fa4338delhi-pl.jpg'),
(11,'9.97129864254335','76.29961867205812',2,'Z<XNjcbh','mscsachdscbhd','static/uploads/8c87545e-8599-4b22-a9b0-f2b4c6fa4338delhi-pl.jpg'),
(12,'9.977980240986346','76.28305435180664',3,'anxhbs','mxbcshhsdcgh','static/uploads/4bf66132-5af3-44ae-bd2c-ea31dc8dea20download.jpg'),
(13,'10.168372357484325','76.17278228655938',2,'xmsascdcgcg','xzncbxhgcdsc','static/uploads/9d3f9409-25c9-4376-b525-998afb9d5ad0Hill-Stations-Holidays.jpg'),
(14,'10.588224235593472','76.22486014239503',3,'Mnbxhasxvgscg',',njcjsdcvjhdfsvhdfh','static/uploads/50ec6dee-5571-4d67-8da7-6527d5d500afTaj-Mahal-Agra-feature.jpg'),
(15,'10.988411015665726','76.86756617026545',2,'zxm,ncdshc','mcsndmbdch','static/uploads/75be3785-44fc-4583-9897-1c3059600b51istockphoto-104731717-612x612.jpg');

/*Table structure for table `review` */

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `rating` varchar(100) DEFAULT NULL,
  `review` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `review` */

insert  into `review`(`review_id`,`user_id`,`place_id`,`rating`,`review`,`date`) values 
(1,NULL,2,'5.0','Exellent','2022-11-25'),
(2,3,2,'4.0','verry Good','2022-11-25'),
(3,4,2,'4.0','verry Good','2022-11-25'),
(4,4,3,'4.0','verry Good','2022-11-25'),
(5,4,4,'3.0','good','2022-11-25'),
(6,4,0,'3.0','good','2022-11-30'),
(7,5,3,'5.0','Exellent','2023-12-12'),
(8,5,6,'4.0','verry Good','2023-12-12'),
(9,5,8,'5.0','Exellent','2024-01-10');

/*Table structure for table `travelogue` */

DROP TABLE IF EXISTS `travelogue`;

CREATE TABLE `travelogue` (
  `travelogue_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `place_name` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`travelogue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `travelogue` */

insert  into `travelogue`(`travelogue_id`,`login_id`,`place_name`,`title`,`description`,`date_time`) values 
(13,9,'z dvrb','eqcevd ','sa d f r','2024-01-17 11:04:17'),
(15,9,'acsv','svev','Xsc','2024-01-17 13:37:27'),
(16,8,'ufhfc','hcjc','bcbchc','2024-01-20 16:53:09'),
(17,8,'hccgyfhf','hcgcxh','b bcxf','2024-01-20 16:59:45'),
(18,8,'xxx','xxzpzz','oooo','2024-01-20 16:59:55');

/*Table structure for table `uploads` */

DROP TABLE IF EXISTS `uploads`;

CREATE TABLE `uploads` (
  `upload_id` int(11) NOT NULL AUTO_INCREMENT,
  `travelogue_id` int(11) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `youtube_link` varchar(500) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `upload_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`upload_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `uploads` */

insert  into `uploads`(`upload_id`,`travelogue_id`,`login_id`,`file_path`,`youtube_link`,`description`,`upload_type`) values 
(21,15,9,'static/blogs/5c6f6bd8-3dea-4dd3-a117-afc7b0005912.mp4','https://youtu.be/0DBM1ZK-040?si=wEdsvB-VmATOofLU','https://youtu.be/0DBM1ZK-040?si=wEdsvB-VmATOofLU','video'),
(23,13,9,'static/blogs/d220b3f4-53b1-4538-827c-d7e2136377d9.jpg','dhcbhdsbchdsghsdhgsdcgscvsghcvghsvcgshvcsaghcvgasvcghasvchgavshgcvhgascvghsacghsaghcvgsacvgsagcsavcvsacvasvasvcagsvcgsaghcvsvshcvashghcvsacvhasc','dhcbhdsbchdsghsdhgsdcgscvsghcvghsvcgshvcsaghcvgasvcghasvchgavshgcvhgascvghsacghsaghcvgsacvgsagcsavcv','video'),
(25,15,9,'static/blogs/9e1ad7fc-495e-4fb9-b508-e6a98b0f3b43.mp4','https://youtu.be/0DBM1ZK-040?si=wEdsvB-VmATOofLU','https://youtu.be/0DBM1ZK-040?si=wEdsvB-VmATOofLU','image'),
(26,13,9,'static/blogs/9e1ad7fc-495e-4fb9-b508-e6a98b0f3b43.mp4','https://youtu.be/0DBM1ZK-040?si=wEdsvB-VmATOofLU','https://youtu.be/0DBM1ZK-040?si=wEdsvB-VmATOofLU','video'),
(27,16,8,'static/blogs/5faa3095-a6a0-4ea3-972b-83ac608056be.jpg','cgd','hcgfh','image'),
(28,16,8,'static/blogs/6b08e718-0bc1-4858-9b73-a5fb16c47231.jpg','cgd','hcgfh','image'),
(29,18,8,'static/blogs/8d65cf19-4da0-4823-b839-554ab3491b24.jpg','cuuxf g','xhccgcd','image'),
(30,18,8,'static/blogs/c5d6554f-8b1c-45d6-be19-f6ad644a1acb.jpg','cuuxf g','xhccgcd','image');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `house_name` varchar(100) DEFAULT NULL,
  `pin` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `users` */

insert  into `users`(`user_id`,`login_id`,`first_name`,`last_name`,`house_name`,`pin`,`place`,`phone`,`email`,`latitude`,`longitude`) values 
(5,8,'arun','arun','afin',NULL,'kottayam','9876543210','abc@abc.con.com','9.9760462','76.2864683'),
(6,9,'cfrcc','ffg','fcc','675444','fcc','123456789','ffxxd@gmail.com','0','0');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
