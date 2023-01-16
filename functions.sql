begin transaction delete_train
DROP procedure IF EXISTS delete_train;
CREATE procedure delete_train(trainno_ char(6))
    begin
        if EXISTS(select * from ticket where trainno=trainno_) then
            signal sqlstate 'HY000' set message_text='请先退回车票';
            rollback transaction
            else delete from vehicle_shift where trainno=trainno_;
            commit transaction delete_train
        end if;
    end;

DROP trigger IF EXISTS trigger_buy;
delimiter //
create trigger trigger_buy
before insert on ticket for each row
begin
    declare seat int(5);
    set seat=(select seats_current from infotable
        where trainno=new.trainno and deptdate=new.deptdate);
    if seat<1 then
        signal sqlstate 'HY000' set message_text='此班次车票已售罄';
    end if;
    if new.id not in (select id from passenger where id=new.id) then
        signal sqlstate 'HY000' set message_text='请先填写个人信息';
    end if;
end;//
delimiter ;

DROP procedure IF EXISTS tickets_buy;
CREATE procedure tickets_buy(trainno_ char(6),deptdate_ date,id varchar(50))
    begin
        declare seat int(5);
        set seat=(select seats_current from infotable
                where trainno=trainno_ and deptdate=deptdate_);
        insert into ticket(trainno,deptdate,seatno,id)
            values(trainno_,deptdate_,seat,id);
        update infotable
        set seats_current=seats_current-1
        where trainno=trainno_ and deptdate =deptdate_;
    end;

Drop procedure IF EXISTS information_updating_cn;
CREATE procedure information_updating_cn(new_id varchar(50),new_nationality varchar(10),
                                        telephone bigint(11),new_sex varchar(5),
                                        new_age int(5),new_cnname varchar(20))
    begin
        if new_nationality<>'中国' then
            signal sqlstate 'HY000' set message_text='外国人请自觉移步到外国人信息填写板块填写个人信息';    
        end if;
        if exists (select * from passenger where id=new_id) then
            update passenger set tel=telephone where id=new_id;
            update passenger set nationality=new_nationality where id=new_id;
            update passenger set sex=new_sex where id=new_id;
            update passenger set age=new_age where id=new_id;
        else insert into passenger(id,nationality,tel,sex,age)
            values (new_id,new_nationality,telephone,new_sex,new_age);    
        end if;

        if exists (select * from chinese where id=new_id) then
            update chinese set cnname=new_cnname where id=new_id;
        else insert into chinese(id,cnname) values (new_id,new_cnname);
        end if;
    end;

Drop procedure IF EXISTS information_updating_fr;
CREATE procedure information_updating_fr(new_id varchar(50),new_nationality varchar(10),
                                        telephone bigint(11),new_sex varchar(5),
                                        new_age int(5),new_frname varchar(20),new_passport varchar(50))
    begin
        if new_nationality='中国' then
            signal sqlstate 'HY000' set message_text='中国人民请到中国人信息填写板块填写个人信息';    
        end if;
        if exists (select * from passenger where id=new_id) then
            update passenger set tel=telephone where id=new_id;
            update passenger set nationality=new_nationality where id=new_id;
            update passenger set sex=new_sex where id=new_id;
            update passenger set age=new_age where id=new_id;
        else insert into passenger(id,nationality,tel,sex,age)
            values (new_id,new_nationality,telephone,new_sex,new_age);    
        end if;

        if exists (select * from foreigner where id=new_id) then
            update foreigner set frname=new_frname where id=new_id;
            update foreigner set passportno=new_passport where id=new_id;
        else insert into foreigner(id,frname,passportno) values (new_id,new_frname,new_passport);
        end if;
    end;

DROP view if exists tickets_search;
CREATE view tickets_search
    as 
    select trainno,deptdate,depttime,arvtime,seats_current,price,s1.stationname as dept,s2.stationname as arv
    from 
    infotable natural join vehicle_shift , station s1,station s2
    where
    vehicle_shift.dept_station=s1.stationno and vehicle_shift.arv_station=s2.stationno

            
DROP procedure IF EXISTS delete_tickets;
CREATE procedure delete_tickets(trainno_ char(6),id_ varchar(50))
    begin
        if EXISTS(select * from ticket where trainno=trainno_ and id=id_) then
						UPDATE infotable
						set seats_current=seats_current+1  where trainno=trainno_;
						delete from ticket where trainno=trainno_ and id=id_;    
            else signal sqlstate 'HY000' set message_text='你并没有购买本车次的车票';
				end if;
    end;