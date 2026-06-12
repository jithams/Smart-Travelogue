from flask import *

from database import *

import uuid

admin=Blueprint('admin',__name__)

@admin.route('admin_home',methods=['get','post'])
def admin_home():
	if not session.get("login_id") is None:
		return render_template("admin_home.html")
	else:
		return redirect(url_for("public.login"))

@admin.route('admin_view_reg_user',methods=['get','post'])
def admin_view_reg_user():
	data={}
	if not session.get("login_id") is None:
		q="SELECT *,concat(first_name,' ',last_name) as user_name FROM `users`"
		res=select(q)
		data['view_user']=res
		
		return render_template('admin_view_reg_user.html',data=data)
	else:
		return redirect(url_for("public.login"))


@admin.route('admin_manage_place_type',methods=['get','post'])
def admin_manage_place_type():
	if not session.get("login_id") is None:
		data={}
		if 'action' in request.args:
			action=request.args['action']
			tid=request.args['tid']
		else:
			action=None
		print(action)

		if action=="delete":
			q="DELETE FROM `place_type` WHERE `place_type_id`='%s'"%(tid)
			delete(q)
			return redirect(url_for('admin.admin_manage_place_type'))


		if 'type' in request.form:
			p_type=request.form['p_type']

			q="INSERT INTO `place_type` VALUES(NULL,'%s')"%(p_type)
			insert(q)

		q="SELECT * FROM `place_type`"
		res=select(q)
		data['view_type']=res
		
		return render_template('admin_manage_place_type.html',data=data)
	else:
		return redirect(url_for("public.login"))



@admin.route('admin_manage_place',methods=['get','post'])
def admin_manage_place():
	if not session.get("login_id") is None:
		data={}
		if 'action' in request.args:
			action=request.args['action']
			id=request.args['id']
		else:
			action=None
		print(action)

		if action=="delete":
			q="DELETE FROM `places` WHERE `place_id`='%s'"%(id)
			delete(q)
			return redirect(url_for('admin.admin_manage_place'))

		if action=="update":
			q="SELECT * FROM `places` INNER JOIN `place_type` ON `place_type_id`=`type_id`  WHERE `place_id`='%s'"%(id)
			res=select(q)
			data['uplace']=res

		if 'updplace' in request.form:
			title=request.form['title']
			des=request.form['des']
			lati=request.form['lati']
			longi=request.form['longi']
			q="UPDATE `places` SET `latitude`='%s',`longitude`='%s',`title`='%s',`description`='%s' WHERE `place_id`='%s'"%(lati,longi,title,des,id)
			update(q)
			return redirect(url_for('admin.admin_manage_place'))

		if 'place' in request.form:
			ptype=request.form['ptype']
			title=request.form['title']
			des=request.form['des']
			lati=request.form['lati']
			longi=request.form['longi']
			photo=request.files['photo']
			path='static/uploads/'+str(uuid.uuid4())+photo.filename
			photo.save(path)
			place=request.form['place']
			q="INSERT INTO `places` VALUES(NULL,'%s','%s','%s','%s','%s','%s')"%(lati,longi,ptype,title,des,path)
			insert(q)

		q="SELECT * FROM `place_type`"
		res=select(q)
		data['p_type']=res

		q="SELECT * FROM `places` INNER JOIN `place_type` ON `place_type_id`=`type_id`"
		res=select(q)
		data['view_plac']=res
		
		return render_template('admin_manage_place.html',data=data)
	else:
		return redirect(url_for("public.login"))




@admin.route('admin_view_feedback',methods=['get','post'])
def admin_view_feedback():
	if not session.get("login_id") is None:
		data={}
		q="SELECT *,CONCAT(`first_name`,' ',`last_name`) AS user_name FROM `feedback` INNER JOIN `users` USING(`login_id`)"
		res=select(q)
		data['view_feed']=res
		
		return render_template('admin_view_feedback.html',data=data)
	else:
		return redirect(url_for("public.login"))


@admin.route('admin_manage_hotels',methods=['get','post'])
def admin_manage_hotels():
	if not session.get("login_id") is None:

		data={}

		if 'action' in request.args:
			action=request.args['action']
			id=request.args['id']
		else:
			action=None
		print(action)

		if action=="delete":
			q="DELETE FROM `hotels` WHERE `hotel_id`='%s'"%(id)
			delete(q)
			return redirect(url_for('admin.admin_manage_hotels'))

		if action=="update":
			q="SELECT * FROM `hotels` WHERE `hotel_id`='%s'"%(id)
			res=select(q)
			data['uhotel']=res

		if 'uphotel' in request.form:
			hname=request.form['hname']
			about=request.form['about']
			lati=request.form['lati']
			longi=request.form['longi']
			phone=request.form['phone']
			email=request.form['email']
			place=request.form['place']

			q="UPDATE `hotels` SET `hotel_name`='%s',`about`='%s',`latitude`='%s',`longitude`='%s',`phone`='%s',`email`='%s',`place`='%s' WHERE `hotel_id`='%s'"%(hname,about,lati,longi,phone,email,place,id)
			update(q)
			return redirect(url_for('admin.admin_manage_hotels'))

		if 'hotel' in request.form:
			hname=request.form['hname']
			about=request.form['about']
			lati=request.form['lati']
			longi=request.form['longi']
			phone=request.form['phone']
			email=request.form['email']
			photo=request.files['photo']
			path='static/uploads/'+str(uuid.uuid4())+photo.filename
			photo.save(path)
			place=request.form['place']

			q="INSERT INTO `hotels` VALUES(NULL,'%s','%s','%s','%s','%s','%s','%s','%s')"%(hname,about,lati,longi,phone,email,path,place)
			insert(q)

		q="SELECT * FROM `hotels`"
		res=select(q)
		data['view_hotel']=res


		return render_template("admin_manage_hotels.html",data=data)
	else:
		return redirect(url_for("public.login"))

	

@admin.route("admin_manage_packages",methods=['get','post'])
def admin_manage_packages():
	if not session.get("login_id") is None:
		data={}

		q="select * from hotels"
		res=select(q)
		data['view_hotels']=res

		q="select * from packages inner join hotels using(hotel_id)"
		res=select(q)
		data['view_pack']=res

		if 'pack' in request.form:
			hotel_id=request.form['hotel_id']
			title=request.form['title']
			des=request.form['des']
			amount=request.form['amount']

			q="INSERT INTO `packages` VALUES(NULL,'%s','%s','%s','%s')"%(hotel_id,title,des,amount)
			insert(q)

			return redirect(url_for("admin.admin_manage_packages"))

		if 'action' in request.args:
			action=request.args['action']
			id=request.args['id']

		else:
			action=None
		print(action)

		if action=="delete":
			q="delete from packages where package_id='%s'"%(id)
			delete(q)
			return redirect(url_for("admin.admin_manage_packages"))

		if action=="update":
			q="select * from packages inner join hotels using(hotel_id) where package_id='%s'"%(id)
			res=select(q)
			data['upack']=res

		if 'upack' in request.form:
			title=request.form['title']
			des=request.form['des']
			amount=request.form['amount']

			q="UPDATE `packages` SET `title`='%s',`description`='%s',`amount`='%s' WHERE `package_id`='%s'"%(title,des,amount,id)
			update(q)
			return redirect(url_for("admin.admin_manage_packages"))

		return render_template("admin_manage_packages.html",data=data)
	else:
		return redirect(url_for("public.login"))


@admin.route("admin_manage_ntification",methods=['get','post'])
def admin_manage_ntification():
	if not session.get("login_id") is None:
		data={}
		q="SELECT * FROM `users`"
		res=select(q)
		data['vendors']=res
	 
	 
		if 'noti' in request.form:
			title=request.form['title']
			des=request.form['des']
			

			q="INSERT INTO `notifications` VALUES(NULL,'%s','%s',now())"%(title,des)
			insert(q)

		if 'action' in request.args:
			action=request.args['action']
			id=request.args['id']
		else:
			action=None
		print(action)
		
		if action=='update':
			w=" select * from  notifications where notification_id='%s' "%(id)
			data['upd']=select(w)
	  
		if 'upd' in request.form:
			tit=request.form['titl']
			dcr=request.form['desc'] 
			ud="update `notifications`  set title='%s' , description='%s' where notification_id='%s' "%(tit,dcr,id)
			update(ud)
			flash('updated successfully...')
			return redirect(url_for("admin.admin_manage_ntification"))
		
		if action=="delete":
			q="DELETE FROM `notifications` WHERE `notification_id`='%s'"%(id)
			delete(q)
			return redirect(url_for("admin.admin_manage_ntification"))

		

		q="SELECT * FROM `notifications`"
		res=select(q)
		data['view_noti']=res


		return render_template("admin_manage_ntification.html",data=data)
	else:
		return redirect(url_for("public.login"))



@admin.route("adminviewtravaloges",methods=['get','post'])
def adminviewtravaloges():
	if not session.get("login_id") is None:
		data={}

		q="SELECT *,concat(first_name,' ',last_name)as name FROM `travelogue` inner join login on travelogue.login_id=login.login_id inner join users on login.login_id=users.login_id"
		res=select(q)
		data['viewtravalogue']=res
		if 'action' in request.args:
			action=request.args['action']
			id=request.args['travelogue_id']
		else:
			action=None
		print(action)
		
		if action=='active':
			w=" UPDATE `travelogue` SET `t_status`='public' WHERE `travelogue_id`='%s'"%(id)
			update(w)
			return redirect(url_for("admin.adminviewtravaloges"))
	  


		return render_template("adminviewtravaloges.html",data=data)
	else:
		return redirect(url_for("public.login"))

@admin.route("adminviewtravelogueimages",methods=['get','post'])
def adminviewtravelogueimages():
	if not session.get("login_id") is None:
		data={}
		trav_id=request.args['tid']

		if 'idds' in request.args:
			idds=request.args['idds']
			q="delete from uploads where upload_id='%s'" %(idds)
			delete(q)
			return redirect(url_for("admin.adminviewtravelogueimages",tid=trav_id))
		data['val']=trav_id
		q="SELECT * FROM `uploads` WHERE `travelogue_id`='%s'"%(trav_id)
		res=select(q)
		data['viewtravalogue']=res


		return render_template("adminviewtravelogueimages.html",data=data)
	else:
		return redirect(url_for("public.login"))