/*
============================================================================================
PROBLEM STATEMENT 
-------------------

Create a Restaurant Billing System where user can enter the details of an ORDER and it produces
an RECEIPT. Customer wants two menus. First would ask the customer whether to create a new order
or view/update menu. Upon selecting one of these three options, it would take user to a submenu
of Placing Order, where customer can input details, or view menu, or update menu.

============================================================================================

1. The customer wants to be able to input the following details into ORDER:
- Customer Name
- Table Number
- FOOD ITEMs ordered
- Quantity per FOOD ITEM ordered
- PAYMENT METHOD used
- Order ID
- Total Amount

NOTE: Order ID will be automatically generated when creating a new order. Total amount is
also automatically calculated.

============================================================================================

2. Additionally, customer wants to be able to select FOOD ITEMs from a menu while forming
the ORDER from a list of predefined MENU; update that MENU with more FOOD ITEMs or remove any.
Each FOOD ITEM should have the following information.
- Item Name
- Item Price
============================================================================================
*/
#include<iostream>
// #include "include/Billing.hpp"
// #include "include/Order.hpp"
#include "MenuSystem.hpp"

int main(){
    MenuSystem menu;
	// hello
    menu.showMainMenu();
    
    return 0;
}
