from flask import *
from database import *
import qrcode
import demjson
import uuid


api=Blueprint('api',__name__)



@api.route('/login', methods=['post'])
def login():
	username = request.form['uname']
	password = request.form['password']
	print(username)
	print(password)
	q="select * from login where username='%s' and password='%s'"%(username,password)
	res=select(q)
	print(res)
	if res:
		return jsonify(status="success", lid=res[0]['login_id'], type=res[0]["usertype"])
	else:
		return jsonify(status="failure")

@api.route('/user_registration',methods=['post'])
def user_registration():
	data={}
	fname=request.form['fname']
	lname=request.form['lname']
	phone=request.form['phone']
	address=request.form['address']
	place=request.form['place']
	pin=request.form['pin']
	email=request.form['email']
	passw=request.form['passw']
	qr="SELECT * FROM `login` WHERE `username`='%s' OR `password`='%s'"%(email,passw)
	res=select(qr)
	if res:
		data['status']='duplicate'
		return jsonify(status="duplicate")
	else:
		q="INSERT INTO `login` VALUES(NULL,'%s','%s','user')"%(email,passw)
		val=insert(q)
		qr="INSERT INTO `users` VALUES(NULL,'%s','%s','%s','%s','%s','%s','%s','%s','0','0')"%(val,fname,lname,address,pin,place,phone,email)
		insert(qr)
		return jsonify(status="success")

@api.route('/User_view_places', methods=['POST'])
def User_view_places():
    q = "SELECT * FROM `place_type` INNER JOIN `places` ON `place_type`.`place_type_id`=`places`.`type_id`"
    res = select(q)
    print(q)
    return jsonify(status="ok", data=res)


@api.route('/useradd_to_fever', methods=['POST'])
def useradd_to_fever():
    data = {}
    lid = request.form['lid']
    place_id = request.form['place_id']

    # Check if the place is already a favorite for the user
    query = "SELECT * FROM `interests` WHERE `user_id`=(SELECT `user_id` FROM `users` WHERE `login_id`='%s') AND `place_id`='%s'" % (lid, place_id)
    res = select(query)

    if res:
        # Place is already a favorite
        data['status'] = "color is permenet"
    else:
        # Place is not a favorite, add it to favorites
        insert_query = "INSERT INTO `interests` VALUES (NULL, (SELECT `user_id` FROM `users` WHERE `login_id`='%s'), '%s')" % (lid, place_id)
        insert(insert_query)
        data['status'] = 'success'

    return jsonify(data)

@api.route('/userremove_from_fever', methods=['POST'])
def userremove_from_fever():
    data = {}
    lid = request.form['lid']
    place_id = request.form['place_id']
    query = "DELETE FROM `interests` WHERE `user_id` = (SELECT `user_id` FROM `users` WHERE `login_id`='%s') AND `place_id` = '%s'"%(lid,place_id)
    delete(query)
    data['status'] = 'success'
    return jsonify(data)



@api.route('/User_view_hotels', methods=['POST'])
def User_view_hotels():
    q = "SELECT * FROM `hotels`"
    res = select(q)
    print(q)
    return jsonify(status="ok", data=res)

@api.route('/User_view_hotelpackeges', methods=['POST'])
def User_view_hotelpackeges():
	hotel_id = request.form['hotel_id']
	q = "SELECT * FROM `hotels` INNER JOIN `packages` USING(`hotel_id`) WHERE `hotel_id`='%s'"%(hotel_id)

	res = select(q)
	print(q)
	return jsonify(status="ok", data=res)




@api.route('/usersendfeedback',methods=['post'])
def usersendfeedback():
	data={}
	login_id=request.form['lid']
	feed_des=request.form['feedback']
	title=request.form['description']
	q= "INSERT INTO `feedback` VALUES(NULL,(SELECT `user_id` FROM `users` WHERE `login_id`='%s'),'%s','%s',NOW())"% (login_id,title,feed_des)
	print(q)
	id=insert(q)
	return jsonify(status="success")

@api.route('/userviewfeedback',methods=['post'])
def userviewfeedback():
	data = {}

	log_id=request.form['lid']
	
	q="SELECT * FROM `feedback` WHERE `login_id`=(SELECT `user_id` FROM `users` WHERE `login_id`='%s')"%(log_id)
	result = select(q)
	return jsonify(status="ok", data=result)



@api.route('/user_view_noti',methods=['post'])
def user_view_noti():
	data = {}
	log_id=request.form['lid']
	qr="SELECT * FROM `notifications` "
	result = select(qr)
	return jsonify(status="ok", data=result)


@api.route('/Customer_send_complaint',methods=['post'])
def Customer_send_complaint():
    data={}
    log_id=request.form['lid']
    complaint=request.form['complaint']
    q="INSERT INTO `complaints` VALUES(NULL,(SELECT `user_id` FROM `users` WHERE `login_id`='%s'),'%s','pending',curdate())"%(log_id,complaint)
    print(q)
    res=insert(q)
    if res:
        return jsonify(status="success")
    else:
    	return jsonify(status="failed")
       

@api.route('/view_complaint',methods=['post'])
def view_complaint():
    data={}
    log_id=request.form['lid']
    q="SELECT * FROM `complaints` WHERE `user_id`=(SELECT `user_id` FROM `users` WHERE `login_id`='%s')"%(log_id)
    res=select(q)
    if res:
        return jsonify(status="ok", data=res)
    else:
        return jsonify(status="nodata")









@api.route('/user_add_travelogue',methods=['post'])
def user_add_travelogue():
	data={}
	loginid=request.form['lid']
	p_name=request.form['place']
	title=request.form['title']
	des=request.form['description']
	q= "INSERT INTO `travelogue` VALUES(NULL,'%s','%s','%s','%s',NOW(),'block')"%(loginid,p_name,title,des)
	print(q)
	id=insert(q)
	return jsonify(status="success")


@api.route('/user_view_travelogue',methods=['post'])
def user_view_travelogue():
	data = {}
	loginid=request.form['lid']
	qr="SELECT * FROM `travelogue` WHERE `login_id`='%s' and `t_status`='public'"%(loginid)
	result = select(qr)
	return jsonify(status="ok", data=result)



@api.route('/deletetravelogue', methods=['POST'])
def deletetravelogue():
    data = {}
    travelogue_id = request.form['travelogue_id']
    query = "DELETE FROM `travelogue` WHERE `travelogue_id`='%s'"%(travelogue_id)
    delete(query)
    qr="DELETE FROM `uploads` WHERE `travelogue_id`='%s'"%(travelogue_id)
    delete(qr)
    data['status'] = 'success'
    return jsonify(data)


@api.route('/user_upload_file',methods=['post'])
def user_upload_file():

	data={}
	path = ""
	trv_id=request.form['travelogue_id']
	yts=request.form['yts']
	desc=request.form['desc']
	logid=request.form['lid']
	image=request.files['file']
	ftype = request.form['ftype']

	if ftype == 'video':
		path='static/blogs/'+str(uuid.uuid4())+ ".mp4"
		image.save(path)
	else:
		path='static/blogs/'+str(uuid.uuid4())+ ".jpg"
		image.save(path)
	q="INSERT INTO `uploads` VALUES(NULL,'%s','%s','%s','%s','%s','%s')"%(trv_id,logid,path,yts,desc,ftype)
	print(q)
	res=insert(q)
	if res:
		return jsonify(status="success")
	else:
		return jsonify(status="failure")


@api.route('/myuser_view_videos', methods=['post'])
def myuser_view_videos():
    data = {}
    trav_id = request.form['travelogueId']
    # qr = "SELECT * FROM `uploads` WHERE `travelogue_id`='%s'" % (trav_id)
    qr = "SELECT * FROM `uploads` where upload_type='video' and `travelogue_id`='%s'"%(trav_id)
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)

@api.route('/myuser_delete_videos', methods=['post'])
def myuser_delete_videos():
	data={}
	upload_id=request.form['upload_id']
	qr="DELETE FROM `uploads` WHERE `upload_id`='%s'"%(upload_id)
	delete(qr)
	return jsonify(status="ok")



@api.route('/myUser_view_travel_images', methods=['post'])
def myUser_view_travel_images():
    data = {}
    trav_id = request.form['travelogueId']
    # qr = "SELECT * FROM `uploads` WHERE `travelogue_id`='%s'" % (trav_id)
    qr = "SELECT * FROM `uploads` where upload_type='image' and `travelogue_id`='%s'"%(trav_id)
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)


@api.route('/myuser_delete_images', methods=['post'])
def myuser_delete_images():
	data={}
	upload_id=request.form['upload_id']
	qr="DELETE FROM `uploads` WHERE `upload_id`='%s'"%(upload_id)
	delete(qr)
	return jsonify(status="ok")



@api.route('/My_view_travelogue',methods=['post'])
def My_view_travelogue():
	data = {}
	loginid=request.form['lid']
	qr="SELECT * FROM `travelogue` WHERE `login_id`='%s' and `t_status`='public'"%(loginid)
	result = select(qr)
	return jsonify(status="ok", data=result)


@api.route('/user_view_images_videos', methods=['post'])
def user_view_images_videos():
    data = {}
    trav_id = request.form['travelogueId']
    # qr = "SELECT * FROM `uploads` WHERE `travelogue_id`='%s'" % (trav_id)
    qr = "SELECT * FROM `uploads` where upload_type='video' and `travelogue_id`='%s'"%(trav_id)
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)


@api.route('/User_view_travel_images', methods=['post'])
def User_view_travel_images():
    data = {}
    trav_id = request.form['travelogueId']
    # qr = "SELECT * FROM `uploads` WHERE `travelogue_id`='%s'" % (trav_id)
    qr = "SELECT * FROM `uploads` where upload_type='image' and `travelogue_id`='%s'"%(trav_id)
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)


@api.route('/UserViewOthersTravelogue',methods=['post'])
def UserViewOthersTravelogue():
	data = {}
	loginid=request.form['lid']
	qr="SELECT * FROM `travelogue` WHERE `login_id` <> '%s' and `t_status`='public'"%(loginid)
	print(qr,"vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv")
	result = select(qr)
	return jsonify(status="ok", data=result)




@api.route('/PublicViewOthersTravelogue',methods=['post'])
def PublicViewOthersTravelogue():
	data = {}
	loginid=request.form['lid']
	qr="SELECT * FROM `travelogue` "
	result = select(qr)
	return jsonify(status="ok", data=result)




@api.route('/PublicviewTravelVideos', methods=['post'])
def PublicviewTravelVideos():
    data = {}
    trav_id = request.form['travelogueId']
    # qr = "SELECT * FROM `uploads` WHERE `travelogue_id`='%s'" % (trav_id)
    qr = "SELECT * FROM `uploads` where upload_type='video' and `travelogue_id`='%s'"%(trav_id)
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)


@api.route('/PublicviewTravelImages', methods=['post'])
def PublicviewTravelImages():
    data = {}
    trav_id = request.form['travelogueId']
    # qr = "SELECT * FROM `uploads` WHERE `travelogue_id`='%s'" % (trav_id)
    qr = "SELECT * FROM `uploads` where upload_type='image' and `travelogue_id`='%s'"%(trav_id)
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)








@api.route('/UserAddBagdetails',methods=['post'])
def UserAddBagdetails():
	data={}
	loginid=request.form['lid']
	title=request.form['title']
	weight=request.form['weight']
	des=request.form['details']
	# qr_code_filename = "static/qr_code_product/"  + str(om_ids)+ ".png"
	# qr_code_data = f"{om_ids}"
	# img = qrcode.make(qr_code_data)
	# img.save(qr_code_filename)

	q= "INSERT INTO `bag_details` VALUES(NULL,(SELECT `user_id` FROM `users` WHERE `user_id`='%s'),'%s','%s','%s',curdate(),'0')"%(loginid,title,weight,des)
	print(q)
	res=insert(q)
	print(res,"hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
	# qr="SELECT * FROM bag_details INNER JOIN `users` USING(`user_id`) WHERE `bag_id`='%s'"%(res)




	qr="SELECT `users`.`first_name`,`users`.`last_name`,`users`.`place`,`users`.`phone`,`bag_details`.`title`,`bag_details`.`weight`,`bag_details`.`details` FROM bag_details INNER JOIN `users` USING(`user_id`) WHERE `bag_id`='%s'"%(res)
	myval=select(qr)
	print(type(myval))

	
	qr_code_filename = "static/qr_code_bag/"  + str(res)+ ".png"
	qr_code_data = f"{myval}"
	print("qrrrrrrrrrrrrrrrrrrrrrdata",qr_code_data)
	img = qrcode.make(qr_code_data)
	img.save(qr_code_filename)
	qc="UPDATE `bag_details` SET `qr_code`='%s' WHERE `bag_id`='%s'"%(qr_code_filename,res)
	update(qc)

	return jsonify(status="success")



@api.route('/Viewbag_details_user', methods=['post'])
def details_user():
    data = {}
    qr = "SELECT * FROM `bag_details` INNER JOIN `users` USING(`user_id`)"
    print(qr)
    result = select(qr)
    return jsonify(status="ok", data=result)




@api.route('/Userbooktour', methods=['post'])
def Userbooktour():
	data = {}
	login_id = request.form['lid']
	package_id = request.form['package_id']
	totalamt = request.form['totalamt']
	date_input = request.form['date']
	ss=date_input.split(' ')
	print(ss, "mncbsdcdcvdsvcsdgvcdgsncvdsnccerfv")
	quantity = request.form['quantity']
	qr = "SELECT * FROM booking WHERE package_id='%s' AND user_id=(SELECT user_id FROM users WHERE login_id='%s') AND booking_date='%s'" % (package_id, login_id, ss[0])
	res = select(qr)

	if res:
		data['status'] = "duplicate"
		return jsonify(status="duplicate")
	else:
		q = "INSERT INTO booking VALUES(NULL, '%s', (SELECT user_id FROM users WHERE login_id='%s'), '%s', CURDATE(), '%s', '%s', 'pending')" % (package_id, login_id, quantity, ss[0], totalamt)
		print(q)
		id = insert(q)
		return jsonify(status="success")

@api.route('/UserViewBookingDetails', methods=['POST'])
def UserViewBookingDetails():
	lid = request.form['lid']
	q = "SELECT * FROM booking INNER JOIN packages USING(package_id)  INNER JOIN hotels using(hotel_id) WHERE user_id=(SELECT user_id FROM users WHERE login_id='%s')"%(lid)
	print(q,"0000000000000000000000000000")
	res = select(q)
	print(q)
	return jsonify(status="ok", data=res)

@api.route('/UserMankepayment',methods=['post'])
def UserMankepayment():
	data={}
	amount=request.form['amount']
	book_id=request.form['book_id']
	lid=request.form['lid']
	q="INSERT INTO payment VALUES(null,'%s','%s',curdate())"%(book_id,amount)
	val=insert(q)
	qr="UPDATE booking SET booking_status='paid' WHERE booking_id='%s'"%(book_id)
	update(qr)
	return jsonify(status="success")


