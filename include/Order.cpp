#include "Order.hpp"
#include "MenuSystem.hpp"


Order::Order() : _menu(nullptr)
{
    orderID = rand() % 1000;
}

Order::~Order()
{
    
}

void Order::collectCustomerDetails()
{
    std::cout<<"Enter customer name: ";
    std::cin>>customerName;
    std::cout<<"Enter table number: ";
    std::cin>>tableNumber;
    std::cout<<"Enter payment method: ";
    std::cin>>paymentMethod;
}

void Order::setMenu(MenuSystem &menu)
{
    _menu = &menu;
}

void Order::getOrderDetails()
{
    std::string itemName;

    std::cout<<"Number of item: ";
    std::cin>>itemNo;
    int i = 0;
    while(i < itemNo)
    {
        std::cout<<"Enter item name: ";
        std::cin>>itemName;
        FoodItem item = _menu->getItemByName(itemName);
        int quantity;
        std::cout<<"Enter quantity: ";
        std::cin>>quantity;
        items.push_back({item, quantity});
        i++;
    }
}