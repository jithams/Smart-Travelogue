/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.9 : Database - smarttravalogue
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smarttravalogue` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `smarttravalogue`;

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`feedback_id`,`login_id`,`title`,`description`,`date_time`) values 
(16,8,'park','awesomeQ','2022-11-16 22:38:42'),
(17,5,'hee','hooo ','2023-12-11 16:47:47'),
(18,NULL,'hh','xx','2024-01-01 11:14:13');

/*Table structure for table `history` */

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_type_id` int(11) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `hotels` */

insert  into `hotels`(`hotel_id`,`hotel_name`,`about`,`latitude`,`longitude`,`phone`,`email`,`photo`,`place`) values 
(2,'Taj','heeeee','9.984045118872803','76.28057709400555','9061442266','aru487@gmail.com','static/uploads/3c98a49e-a5b5-4731-b37c-214395def09awp8672430.jpg','kochi');

/*Table structure for table `interests` */

DROP TABLE IF EXISTS `interests`;

CREATE TABLE `interests` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `interests` */

insert  into `interests`(`interest_id`,`login_id`,`type_id`) values 
(10,8,2),
(11,8,3);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usertype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`usertype`) values 
(1,'admin','admin','admin'),
(2,'ss','ss','user'),
(5,'f','f','user'),
(6,'user','user','user'),
(7,'ann','users','user'),
(8,'ar','ar','user');

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `notification` */

insert  into `notification`(`notification_id`,`user_id`,`place_id`,`latitude`,`longitude`,`place`) values 
(1,5,7,'9.966314554146333','76.28657341003418','pala');

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `date_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `packages` */

insert  into `packages`(`package_id`,`hotel_id`,`title`,`description`,`amount`) values 
(1,1,' rew  ',' hvfdcx ','12'),
(6,2,'One day','Enjoyyyy......','3200');

/*Table structure for table `place_type` */

DROP TABLE IF EXISTS `place_type`;

CREATE TABLE `place_type` (
  `place_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`place_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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
  PRIMARY KEY (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `places` */

insert  into `places`(`place_id`,`latitude`,`longitude`,`type_id`,`title`,`description`) values 
(5,'9.986348845905287','76.27498626708984',3,'sasdxdqs','sxwssw'),
(7,'9.966314554146333','76.28657341003418',2,'SUBHASH','heeee heeee'),
(8,'9.870629943412304','76.37808983338826',3,'pala','heee heeee'),
(9,'9.976318645792988','76.28627970814705',3,'Riss','Technologiess'),
(10,'9.976318645792988','76.28627970814705',3,'alarammmmmmm','adikkatteeeee');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `travelogue` */

insert  into `travelogue`(`travelogue_id`,`login_id`,`place_name`,`title`,`description`,`date_time`) values 
(1,2,'sample','testing','qwerty','2020-11-23 19:36:04'),
(2,2,'kollam','jice','hshshsb','2022-10-17 15:44:14'),
(3,6,'kollM','buhhhh','buygh','2022-10-19 12:08:52'),
(4,6,'uhy','ghg','hhh','2022-11-03 16:11:47'),
(5,6,'places ','assdddfghhj','tgvnhuj','2022-11-15 16:45:54'),
(6,7,'kollam','nice','awesome ','2022-11-16 10:41:16'),
(7,6,'hhhhh','vggggg','vgggggg','2022-11-16 12:23:37'),
(8,8,'zzzz','zzzzzz','zzzzz','2022-11-16 12:23:52'),
(9,8,'dufaaiii','in flight','hooo hooo','2023-12-11 16:44:05'),
(10,5,'gggg','hhh','yhyy','2024-01-01 11:12:22');

/*Table structure for table `uploads` */

DROP TABLE IF EXISTS `uploads`;

CREATE TABLE `uploads` (
  `upload_id` int(11) NOT NULL AUTO_INCREMENT,
  `travelogue_id` int(11) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `youtube_link` varchar(500) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`upload_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `uploads` */

insert  into `uploads`(`upload_id`,`travelogue_id`,`login_id`,`file_path`,`youtube_link`,`description`) values 
(1,1,2,'static/uploads/9b727445-3afd-46b3-aa08-1c608948308e.mp4','fh','gh'),
(2,1,2,'static/uploads/35093755-05f5-4864-8965-60b097f4e5f4.jpg','dg','h'),
(3,1,2,'static/uploads/757cb823-a401-435c-a482-b10f22b795e4.jpg','fhu','jj'),
(4,1,2,'static/uploads/c352241a-9448-4e1b-85b2-b890ad4b3ad0.jpg','','hjhfhj'),
(5,2,2,'static/uploads/f64b117a-87d9-42c6-ba6d-8d28a61bc90c.jpg','ghggyu.com','huyg'),
(6,3,6,'static/uploads/78cab66a-e561-4e13-aeda-9401633409ff.jpg','hjjjj','bbbb'),
(7,3,6,'static/uploads/5ad6d3ac-fbc4-4645-85b8-67fd82be1d61.jpg','hhhhg','fggg'),
(8,6,7,'static/uploads/3162d012-f9a4-4c7c-9b2c-3d2c2ca590f1.jpg','hhuuu','jjjj'),
(9,6,7,'static/uploads/30e3669c-9fba-474a-8d9a-b64caa9f5941.jpg','nhjhh','bbbbh'),
(10,8,6,'static/uploads/37dd5bf7-fda7-4dcd-a24d-89393f2a8b8e.jpg','bjjjjj','vhbbh'),
(11,9,8,'static/uploads/27d13f10-5968-405f-a0ac-418899c9551d.jpg','','wooooo woooo');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `dob` varchar(100) DEFAULT NULL,
  `house_name` varchar(100) DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`user_id`,`login_id`,`first_name`,`last_name`,`gender`,`dob`,`house_name`,`place`,`phone`,`email`,`latitude`,`longitude`) values 
(5,8,'arun','arun','Male','24/11/2022','afin','kottayam','9876543210','abc@abc.con.com','9.9760462','76.2864683');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
