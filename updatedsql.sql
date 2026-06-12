/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.9 : Database - flutter_smarttravalogue_kristhu
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`flutter_smarttravalogue_kristhu` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `flutter_smarttravalogue_kristhu`;

/*Table structure for table `bag_details` */

DROP TABLE IF EXISTS `bag_details`;

CREATE TABLE `bag_details` (
  `bag_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `details` varchar(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `qr_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `bag_details` */

insert  into `bag_details`(`bag_id`,`user_id`,`title`,`weight`,`details`,`date`,`qr_code`) values 
(1,1,'30kg','Red Bag','If found please send to kochin transport hub ','2024-04-05','static/qr_code_bag/1.png'),
(2,1,'50kg','Orange Bag','hdhdhdhdjdjd','2024-04-05','static/qr_code_bag/2.png'),
(3,3,'30kg',' Luggage','If Found Please contact ','2024-04-05','static/qr_code_bag/3.png');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`feedback_id`,`login_id`,`title`,`description`,`date_time`) values 
(1,1,'Good App','bhfhdhdh','2024-04-05 12:42:23'),
(2,2,'Good App','love ittt','2024-04-05 13:03:05'),
(3,3,'Appo is Good','bsndjdjdjddj','2024-04-05 13:04:17');

/*Table structure for table `history` */

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_type_id` int(11) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `history` */

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `hotels` */

insert  into `hotels`(`hotel_id`,`hotel_name`,`about`,`latitude`,`longitude`,`phone`,`email`,`photo`,`place`) values 
(1,'Riss Hotel','Good Hotel','9.979852332891728','76.28133673541261','8897987676','risshotel@gmail.com','static/uploads/d7bb2632-bd81-4a1a-a860-08a38ff5224dWhatsApp Image 2024-03-12 at 19.56.13_838f0a61.jpg','Kochi'),
(2,'Radisson Blu','kglg,uigiugiugiu','9.967328978273532','76.30717277526855','9799898798','radissonblu@gmail.com','static/uploads/fc9ea486-a7f4-41d5-a554-f09c71c56c8eWhatsApp Image 2024-03-12 at 19.56.09_724dadd4.jpg','Elamkulam'),
(3,'Holiday Inn','holiday inn attractive hotel','9.99023721537169','76.31575584411621','6757656756','holidayinn@gmail.com','static/uploads/714c9819-d51e-46c9-a2e7-3aa5e9ecb10dWhatsApp Image 2024-03-12 at 19.56.14_1a78ae4f.jpg','Elamkulam'),
(4,'Crown Plaza','besttt Hotel','9.93418949271221','76.31867408752441','8776787687','crownplaza@gmail.com','static/uploads/904bd849-1fc2-4928-8d8c-ef737f64a969WhatsApp Image 2024-03-12 at 19.56.08_b81c1b3c.jpg','Maradu');

/*Table structure for table `interests` */

DROP TABLE IF EXISTS `interests`;

CREATE TABLE `interests` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `interests` */

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usertype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`usertype`) values 
(1,'abhi@gmail.com','abhi','user'),
(2,'u','u','user'),
(3,'nish@gmail.com','nisha','user'),
(4,'admin','admin','admin');

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `notifications` */

insert  into `notifications`(`notification_id`,`title`,`description`,`date_time`,`user_id`) values 
(1,'New update Announcement','travelegg 2.0','2024-04-05 13:05:14',2),
(2,'asxasmxs','sxbmsaxmasas','2024-04-12 21:06:59',3);

/*Table structure for table `packages` */

DROP TABLE IF EXISTS `packages`;

CREATE TABLE `packages` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `amount` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `packages` */

insert  into `packages`(`package_id`,`hotel_id`,`title`,`description`,`amount`) values 
(1,1,'3 Day Package','3 days 3 night package      \r\n breakfast, lunch included ','10000'),
(2,2,'5 days Package','kjhkgkgiguigjgiugugbukgukgu','20000'),
(3,3,'7 Day Package','vjhvmhkvkvkjbkjvkjv','50000'),
(4,4,'3 day package','iugkgigkugogkgigl','70000');

/*Table structure for table `place_type` */

DROP TABLE IF EXISTS `place_type`;

CREATE TABLE `place_type` (
  `place_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`place_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `place_type` */

insert  into `place_type`(`place_type_id`,`type_name`) values 
(1,'Police station'),
(2,'Hospital'),
(3,'Park'),
(4,'School'),
(5,'Attractive Place'),
(6,'Hotel');

/*Table structure for table `places` */

DROP TABLE IF EXISTS `places`;

CREATE TABLE `places` (
  `place_id` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `place_image` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `places` */

insert  into `places`(`place_id`,`latitude`,`longitude`,`type_id`,`title`,`description`,`place_image`) values 
(1,'9.980512738184826','76.29918951861573',1,'Kochi Police Station','law and order in kochi','static/uploads/98909928-16fe-4408-a6cd-1397b91a61fcdownload.png'),
(2,'9.962845114642896','76.29549879901124',2,'Pushpagiri Hospital','ghjggkugi','static/uploads/fbf74843-f060-491d-b7bf-b53cba59a446download.jpeg'),
(3,'9.462100164347458','76.54775619506836',4,'Kristu Jyoti College','Top College','static/uploads/e7495fc4-6f2f-4f3f-a296-d71e2cc5edbadownload (1).jpeg'),
(4,'9.978568501169137','76.27970595233155',6,'Riss Hotel','Good Hotel','static/uploads/29f5670e-3b15-46eb-825d-7d11989096f6WhatsApp Image 2024-03-12 at 19.56.13_838f0a61.jpg'),
(5,'9.980343674557364','76.29979033343507',1,'Alathoor Police Station','JHHJJVJHVJH','static/uploads/bc904dbf-d929-43b9-acdb-02d2deffa0a3download.png'),
(6,'9.381406955450892','76.57977104187012',2,'Pushpagiri Hospital','Pushpagiri thiruvalla','static/uploads/0c5dd220-f9df-47f5-809b-f7acce581dc0download.jpeg'),
(7,'9.971555711492252','76.27936363220215',3,'Subash Park','A fun place to Hang Out','static/uploads/671ffa82-e8dd-4889-80d9-e07895c2d09cWhatsApp Image 2024-03-12 at 19.56.16_3ece6bd1.jpg'),
(8,'10.175049874607875','76.54672622680664',5,'Puliyanpara View Point','Sunrise view','static/uploads/89e002b6-9fb3-4eb3-baac-c46816e60c7bWhatsApp Image 2024-03-12 at 19.56.17_83170220.jpg'),
(9,'9.967328978273532','76.30717277526855',6,'Radisson Blu Hotel','radisso blue kochi','static/uploads/2d454197-05dd-4b18-8eb0-df272677c432WhatsApp Image 2024-03-12 at 19.56.14_ca13d581.jpg'),
(10,'9.99023721537169','76.31575584411621',6,'Holiday Inn Hotel','jhgjhvjhvjhvjhvhj','static/uploads/fffdd009-9407-4e51-9403-6f072356d7b6WhatsApp Image 2024-03-12 at 19.56.13_838f0a61.jpg'),
(11,'10.032921689676245','76.2934398651123',2,'Amrita Hospital','kochin hospital','static/uploads/285e96c2-432b-42e1-b3e4-3896917bb0b2download.jpeg'),
(12,'9.93418949271221','76.31867408752441',6,'Crown Plaza ','GIUGIUGUIGGU','static/uploads/f6f7c47b-a68f-4c17-a7a6-40c16562d343WhatsApp Image 2024-03-12 at 19.56.11_3d030b9c.jpg');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `review` */

/*Table structure for table `travelogue` */

DROP TABLE IF EXISTS `travelogue`;

CREATE TABLE `travelogue` (
  `travelogue_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `place_name` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  `t_status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`travelogue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `travelogue` */

insert  into `travelogue`(`travelogue_id`,`login_id`,`place_name`,`title`,`description`,`date_time`,`t_status`) values 
(1,1,'KASHMIR','Heaven','Best place to visit','2024-04-05 12:41:44','public'),
(2,2,'Goa','VIBE PLACE','the best experience ','2024-04-05 13:02:21','block'),
(3,3,'IDUKKI','beautiful place','one of the natural wonders of kerala','2024-04-05 13:03:58','public'),
(4,2,'bb','bbb','hhh','2024-04-12 21:41:12','public');

/*Table structure for table `uploads` */

DROP TABLE IF EXISTS `uploads`;

CREATE TABLE `uploads` (
  `upload_id` int(11) NOT NULL AUTO_INCREMENT,
  `travelogue_id` int(11) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  `file_path` varchar(1000) DEFAULT NULL,
  `youtube_link` varchar(500) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `upload_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`upload_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `uploads` */

insert  into `uploads`(`upload_id`,`travelogue_id`,`login_id`,`file_path`,`youtube_link`,`description`,`upload_type`) values 
(1,2,2,'static/blogs/341e58d8-058b-4b75-aa79-4121b5290403.jpg','','','image'),
(2,1,1,'static/blogs/75ad0026-d811-4d09-9531-d5dff8f8a2bb.jpg','','','image'),
(3,1,1,'static/blogs/08fb50cb-354f-4793-943c-d6b01e02082d.jpg','','','image');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`user_id`,`login_id`,`first_name`,`last_name`,`house_name`,`pin`,`place`,`phone`,`email`,`latitude`,`longitude`) values 
(1,1,'Abhijith','Ajith','Rdx,kuttanad,mambuzhakary','658489','Alappuzha','7474748999','abhi@gmail.com','0','0'),
(2,2,'Abel','Tom','bdhdjdjdjdj','647477','Kottayam','8488574749','abel@gmail.com','0','0'),
(3,3,'nisha','jacob','jsjdjdjdkdj','163789','chengannur','7484848480','nish@gmail.com','0','0');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
