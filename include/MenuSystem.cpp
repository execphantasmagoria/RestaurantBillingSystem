#include "MenuSystem.hpp"
#include <limits>

void MenuSystem::showMainMenu()
{
    int choice = 0;

    while (true)
    {
        _mainMenu.display();
        std::cin>>choice;

        // Clear the input buffer in case of invalid input to prevent infinite loop
        if (!std::cin) {
            std::cin.clear();
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            choice = -1;
        }

        switch(choice)
        {
            case 1:
                // showNewOrderMenu();
                std::cout<<"New Order Menu coming soon!"<<std::endl;
                break;
            case 2:
                // showOrderListMenu();
                std::cout<<"Order List Menu coming soon!"<<std::endl;
                break;
            case 3:
                // showFoodMenu();
                std::cout<<"Food Menu coming soon!"<<std::endl;
                break;
            case 4:
                std::cout<<"Thank you for using the Restaurant Billing System!"<<std::endl;
                return; // exit the function
            default:
                std::cout<<"Invalid choice. Please try again."<<std::endl;
                break; // continue the loop
        }
    }
}

void MenuSystem::showNewOrderMenu()
{
}

void MenuSystem::showAddItemToOrderMenu()
{
}

void MenuSystem::showRemoveItemFromOrderMenu()
{
}

void MenuSystem::showSettleOrderMenu()
{
}

void MenuSystem::showFoodMenu()
{
}

void MenuSystem::showAddFoodItemMenu()
{
}

void MenuSystem::showRemoveFoodItemMenu()
{
}

void MenuSystem::showOrderEditMenu()
{
}

void MenuSystem::showOrderListMenu()
{
}

FoodItem MenuSystem::getItemByName(const std::string& itemName)
{
    for(const auto& item : itemList)
    {
        if(item.getItemName() == itemName) return item;
    }
    return FoodItem();
}