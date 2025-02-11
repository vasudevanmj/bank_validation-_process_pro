create or replace  package   xxits_bank_details
as
    procedure customer_account_details(p_bank  in varchar2);
    procedure customer_account_details;
    procedure   withdraw_amount(P_amount number,P_id number);
    procedure   deposite_amount(P_amount number,P_id number);
    function  xxits_count_bank_func return  number;
end;