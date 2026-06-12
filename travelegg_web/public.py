from flask import *

from database import *

public=Blueprint('public',__name__)

@public.route('/')
def index():
	return render_template('index.html')

@public.route('/login',methods=['get','post'])
def login():
	session.clear()
	if 'login' in request.form:
		uname=request.form['uname']
		passw=request.form['pass']

		q="select * from login where username='%s' and password='%s'"%(uname,passw)
		res=select(q)

		if res:
			session['login_id']=res[0]['login_id']
			if res[0]['usertype']=="admin":
				return redirect(url_for('admin.admin_home'))

	return render_template('login.html')

