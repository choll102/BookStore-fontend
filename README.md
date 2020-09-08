# da_muasachonline

// nguyên phần event : tạo class kế thừa . sử dụng tuần OPP . 
/// base
-- phần base : tách ra UI and logic . base bloc nhận logic . 
-- base event nhận sự kiện từ các base event khác . sử dụng thuần . desginer patter (signle tone )
-- base widget : đảm nhận UI chung . khung sường 
// data : call gọi API . từ database
order_service : nhận event từ các oder  . gửi qua base_evnet
product_service : call list product từ database lên . load UI .
User_service : call class đối tượng User . tiến hành sử lí event 
-------------- những thứ từ remote đều là khởi tạo contruster . đối tượng -------------

