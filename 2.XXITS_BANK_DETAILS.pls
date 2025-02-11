create or replace  package body xxits_bank_details
as

    procedure customer_account_details(p_bank  in varchar2)
    as
    cursor bank is
    select  b.acc_type      , b.creation_date_b ,   b.balalce ,      b.bank_name    ,
            c.address       , c.age             ,   c.name    ,      cust_id        ,   b.acc_id 
    from    xxits_bms_account_det_t     b       ,
            xxits_bms_customer_det_t    c
    where   b.acc_id    =   c.acc_id
    and      bank_name  =   p_bank;  
    begin
        for i  in   bank
        loop
            dbms_output.put_line('customer_id: '    ||i.cust_id);
            dbms_output.put_line('account_id:   '   ||i.acc_id);
            dbms_output.put_line('acc_type:'        ||i.acc_type);
            dbms_output.put_line('bank_name:'       ||i.bank_name);
            dbms_output.put_line('createion_date:'  ||i.creation_date_b);
            dbms_output.put_line('balace:'          ||i.balalce);
            dbms_output.put_line('name:'            ||i.name);
            dbms_output.put_line('age:'             ||i.age);
            dbms_output.put_line('address:'         ||i.address);
            dbms_output.put_line('---------******---------------');
        
        end loop;
    end;
        procedure customer_account_details
    as
    cursor bank is
    select  b.acc_type      , b.creation_date_b ,   b.balalce ,      b.bank_name    ,
            c.address       , c.age             ,   c.name    ,      cust_id        ,   b.acc_id 
    from    xxits_bms_account_det_t     b       ,
            xxits_bms_customer_det_t    c
    where   b.acc_id    =   c.acc_id;
    begin
        for i  in   bank
        loop
            dbms_output.put_line('customer_id: '    ||i.cust_id);
            dbms_output.put_line('account_id:   '   ||i.acc_id);
            dbms_output.put_line('acc_type:'        ||i.acc_type);
            dbms_output.put_line('bank_name:'       ||i.bank_name);
            dbms_output.put_line('createion_date:'  ||i.creation_date_b);
            dbms_output.put_line('balace:'          ||i.balalce);
            dbms_output.put_line('name:'            ||i.name);
            dbms_output.put_line('age:'             ||i.age);
            dbms_output.put_line('address:'         ||i.address);
            dbms_output.put_line('---------******---------------');
        
        end loop;
    end;
    
    ----withdraw_amount------
    procedure   withdraw_amount(P_amount number,P_id number)as
    lc_balalce NUMBER;
    BEGIN
        SELECT  balalce
        INTO lc_balalce 
        FROM  xxits_bms_account_det_t
        WHERE acc_id = P_id;

        IF lc_balalce >= P_amount THEN
            UPDATE xxits_bms_account_det_t
            SET balalce = balalce -  P_amount
            WHERE  acc_id = P_id;
            insert  into   xxits_bms_transactions_det_t(tran_id,acc_id,transaction_type,tran_amount,status)values
                                                        (xxits_bms_transactions_det_s.nextval,P_id,'debit',P_amount,'success');
            COMMIT;
            dbms_output.put_line('An amount of INR'||'  ' ||P_amount ||'   ' ||'has been debited to your account');
        ELSE
            dbms_output.put_line('Failed due to Insufficient funds amount:'||'  '||P_amount   );
            insert  into   xxits_bms_transactions_det_t(tran_id,acc_id,transaction_type,tran_amount,status)values
                                                        (xxits_bms_transactions_det_s.nextval,P_id,'debit',P_amount,'rejecte');
        END IF;
    END withdraw_amount;
    
    ------deposite_amount------
    procedure   deposite_amount (P_amount number,P_id number)
    as
    begin
        UPDATE xxits_bms_account_det_t
        SET balalce = balalce +  P_amount
        WHERE  acc_id = P_id;
        insert  into   xxits_bms_transactions_det_t(tran_id,acc_id,transaction_type,tran_amount,status)values
                                                        (xxits_bms_transactions_det_s.nextval,P_id,'credit',P_amount,'success');
        commit;
                dbms_output.put_line('An amount of INR' ||' ' || P_amount || ' '||   'has been credited to your account');
    end deposite_amount;
    ------count_check-----------
    function  xxits_count_bank_func return  number
    as
        lc_count      number;
    begin
        SELECT  count(*)
        into    lc_count
        FROM xxits_bms_transactions_det_t;
        return  lc_count;
    end xxits_count_bank_func;
end xxits_bank_details;