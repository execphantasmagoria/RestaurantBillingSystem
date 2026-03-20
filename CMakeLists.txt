cmake_minimum_required(VERSION 3.10)

project(RestaurantBillingSystem VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Include directories
include_directories(include)

# Source files
set(SOURCES
    src/main.cpp
    include/Billing.cpp
    include/FoodItem.cpp
    include/MenuSystem.cpp
    include/Order.cpp
    include/Menus/MainMenu.cpp
    include/Menus/NewOrderMenu.cpp
)

# Create executable
add_executable(RestaurantBillingSystem ${SOURCES})