#include "Application.h"

#include <iostream>

#include <GLFW/glfw3.h>
#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>

void Application::Initialize() {
    if (!glfwInit())
    {
        // Initialization failed
    }
    std::cout << "Initializing application." << std::endl;
    // @TODO fix
    Assimp::Importer importer; // For test purpose
}

void Application::SayHello() {
    std::cout << "Hello!" << std::endl;
}
