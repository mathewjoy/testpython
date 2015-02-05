from werkzeug import abort
from flask import render_template
from flask import Blueprint
from my_app.product.models import PRODUCTS

product_bp = Blueprint('product',__name__)

@product_bp.route('/')
@product_bp.route('/home')
def home():
	return render_template('home.html',products=PRODUCTS)



@product_bp.route('/product/<key>')
def product(key):
	product=PRODUCTS.get(key)
	if not product:
		abort(404)
	return render_template('product.html', product=product)

