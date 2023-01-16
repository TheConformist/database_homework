import pymysql
import pandas as pd
import traceback
import numpy as np
import duration

def add_CN(ID, Nationality, Telephone, sex, age,cn_name):
    conn = pymysql.connect(
        host="localhost",
        port=3306,
        user="root",
        password="root",
        database="train_booking",
        charset="utf8mb4"
    )
    cursor = conn.cursor()
    sql = "call information_updating_cn(%s,%s,%s,%s,%s,%s);"
    str_end = ''
    try:
        cursor.execute(sql, [ID, Nationality, Telephone, sex, age,cn_name])
        conn.commit()
        str_end = '填写成功!'
    except Exception as e:
        # 有异常，回滚事务
        print('traceback.format_exc():\n%s' % traceback.format_exc())
        conn.rollback()
        str_end = str(e)
    cursor.close()
    conn.close()
    return str_end

def add_FR(ID, Nationality, Telephone, sex, age,fr_name,passportno):
    conn = pymysql.connect(
        host="localhost",
        port=3306,
        user="root",
        password="root",
        database="train_booking",
        charset="utf8mb4"
    )
    cursor = conn.cursor()
    sql = "call information_updating_fr(%s,%s,%s,%s,%s,%s,%s);"
    str_end = ''
    try:
        cursor.execute(sql, [ID, Nationality, Telephone, sex, age,fr_name,passportno])
        conn.commit()
        str_end = 'success!'
    except Exception as e:
        # 有异常，回滚事务
        print('traceback.format_exc():\n%s' % traceback.format_exc())
        conn.rollback()
        str_end = str(e)
    cursor.close()
    conn.close()
    return str_end

# def train_delete(trainno):
#     conn = pymysql.connect(
#         host="localhost",
#         port=3306,
#         user="root",
#         password="root",
#         database="train_booking",
#         charset="utf8mb4"
#     )
#     cursor = conn.cursor()
#     sql = "call delete_train(%s);"
#     try:
#         cursor.execute(sql, trainno)
#         # 运行成功，提交事务
#         conn.commit()
#         str_end = 'Success'
#
#     except Exception as e:
#         # 有异常，回滚事务
#         print('traceback.format_exc():\n%s' % traceback.format_exc())
#         conn.rollback()
#         str_end = str(e)
#
#     cursor.close()
#     conn.close()
#     return str_end


def tickets_buy(Trainno,DeptDate,id):
    conn = pymysql.connect(
        host="localhost",
        port=3306,
        user="root",
        password="root",
        database="train_booking",
        charset="utf8mb4"
    )
    cursor = conn.cursor()
    sql = "call tickets_buy(%s,%s,%s);"
    try:
        cursor.execute(sql, [Trainno, DeptDate, id])
        conn.commit()
        str_end = 'Success'

    except Exception as e:
        # 有异常，回滚事务
        print('traceback.format_exc():\n%s' % traceback.format_exc())
        conn.rollback()
        str_end = str(e)
    cursor.close()
    conn.close()
    return str_end

def search_train(DeptDate,DeptStation,ArvStation,MaxPrice):
    conn = pymysql.connect(
        host="localhost",
        port=3306,
        user="root",
        password="root",
        database="train_booking",
        charset="utf8mb4"
    )
    cursor = conn.cursor()

    sql = "select *\
                from tickets_search\
                where deptdate=%s and dept=%s and arv=%s and price<=%s;"
    try:

        cursor.execute(sql, [DeptDate, DeptStation, ArvStation, MaxPrice])
        data = cursor.fetchall()
        column = ["车号","出发日期","出发时间","抵达时间","剩余座位数","车票价格","出发地","目的地"]
        data_df = pd.DataFrame(list(data), columns=column)
        if data==():
            str_end="没有相关的车次"
            return (str_end)
        return (data_df)

    except Exception as e:
        print('traceback.format_exc():\n%s' % traceback.format_exc())
        conn.rollback()
        str_end = str(e)
        return str_end


def tickets_delete(trainno,id):
    conn = pymysql.connect(
        host="localhost",
        port=3306,
        user="root",
        password="root",
        database="train_booking",
        charset="utf8mb4"
    )
    cursor = conn.cursor()
    sql = "call delete_tickets(%s,%s);"
    try:
        cursor.execute(sql, [trainno,id])
        # 运行成功，提交事务
        conn.commit()
        str_end = 'Success'

    except Exception as e:
        # 有异常，回滚事务
        print('traceback.format_exc():\n%s' % traceback.format_exc())
        conn.rollback()
        str_end = str(e)
    cursor.close()
    conn.close()

    return str_end
