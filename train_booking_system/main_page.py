import streamlit as st
import pymysql
from sql_function import *
import pandas as pd
import numpy as np


if 'active_page' not in st.session_state:
    st.session_state.active_page = '主页'
    st.session_state.radiobuttons = '主页'

def home():
    st.header('Welcome to train booking system')
    st.subheader('在本页面，你可以进行以下操作')
    col1,col2,col3,col4=st.columns(4)
    with col1:
        st.info("查询车次")
    with col2:
        st.info("购买车票")
    with col3:
        st.info("完善信息")
    with col4:
        st.info("退票")



def my_search():
    st.subheader('车次查询')
    with st.form("输入要查询的列车信息"):
        Deptdate=st.text_input("出发日期",help="请按标准格式输入，如2022-06-01")
        Dept=st.text_input("出发地")
        arv=st.text_input("抵达地")
        price=st.text_input("价格不超过")
        if st.form_submit_button("提交信息"):
            end=search_train(Deptdate,Dept,arv,price)
            st.write(end)



def my_tickets_buy():
    st.subheader('购买车票')
    with st.form("请输入车次信息"):
         trainno=st.text_input("车次号")
         Deptdate = st.text_input("出发日期",help="请按标准格式输入，如2022-06-01")
         id = st.text_input("你的身份证号")
         if st.form_submit_button("提交信息"):
             end=tickets_buy(trainno,Deptdate,id)
             st.text(end)


def fill_in_information_cn():
    st.subheader('请填写个人信息')
    with st.form("填写个人信息"):
        ID = st.text_input("身份证号")
        Nationality = st.text_input("国籍")
        CN_name = st.text_input("姓名")
        Tel = st.text_input("电话号码")
        Sex = st.text_input("性别")
        Age = st.text_input("年龄")

        if st.form_submit_button("提交信息"):
            end=add_CN(ID,Nationality,Tel,Sex,Age,CN_name)
            st.text(end)


def fill_in_information_fr():
    st.subheader('fill in your information')
    with st.form("fill in your information"):
        ID = st.text_input("id number")
        Nationality = st.text_input("nationality")
        FR_name = st.text_input("your name")
        Tel = st.text_input("telephone")
        Sex = st.text_input("sex")
        Age = st.text_input("age")
        Passportno = st.text_input("passport number")

        if st.form_submit_button("give me your info"):
            end = add_FR(ID, Nationality, Tel, Sex, Age, FR_name, Passportno)
            st.text(end)


def my_tickets_delete():
    st.subheader('退票窗口')
    with st.form('请输入要退票的列车号'):
        Trainno = st.text_input("列车号")
        ID=st.text_input("身份证号")
        if st.form_submit_button("提交信息"):
            end=tickets_delete(Trainno,ID)
            st.text(end)


# def my_train_delete():
#     st.subheader('删除车次')
#     with st.form('请输入要删除的列车号'):
#         trainno=st.text_input("列车号")
#         if st.form_submit_button("提交信息"):
#             end=train_delete(trainno)
#             st.text(end)


def CB_RadioButton():
    st.session_state.active_page = st.session_state.radiobuttons

st.sidebar.radio('Page Navigation', ['主页', '车次查询', '购票','信息完善','your information','退票'],
     key='radiobuttons', on_change=CB_RadioButton)


# --- Run the active page
if st.session_state.active_page == '主页':
    home()
elif st.session_state.active_page == '车次查询':
    my_search()
elif st.session_state.active_page == '购票':
    my_tickets_buy()
elif st.session_state.active_page == '信息完善':
    fill_in_information_cn()
elif st.session_state.active_page == 'your information':
    fill_in_information_fr()
elif st.session_state.active_page == '退票':
    my_tickets_delete()
# elif st.session_state.active_page == '删除车次':
#     my_train_delete()