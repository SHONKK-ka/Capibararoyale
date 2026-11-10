#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <whb/log.h>
#include <whb/log_udp.h>

// Capibara Royale Wii U - Wrapper nativo SDL2

int main(int argc, char **argv) {
    WHBLogUdpInit();
    WHBLogPrintf("=== CAPIBARA ROYALE WII U EDITION ===");

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_GAMECONTROLLER) < 0) {
        WHBLogPrintf("SDL Init fallo: %s", SDL_GetError());
        WHBLogUdpDeinit();
        return 0;
    }

    SDL_Window *window = SDL_CreateWindow("Capibara Royale",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        1280, 720, SDL_WINDOW_SHOWN);
    if (!window) {
        WHBLogPrintf("CreateWindow fallo: %s", SDL_GetError());
        SDL_Quit();
        WHBLogUdpDeinit();
        return 0;
    }

    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1,
        SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!renderer) {
        WHBLogPrintf("CreateRenderer fallo: %s", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        WHBLogUdpDeinit();
        return 0;
    }

    IMG_Init(IMG_INIT_PNG);

    // Cargar icono capibara
    SDL_Surface *iconSurf = IMG_Load("fs:/vol/external01/wiiu/apps/CapibaraRoyale/icon.png");
    if (!iconSurf) iconSurf = IMG_Load("assets/capibara.png");

    SDL_Texture *iconTex = nullptr;
    if (iconSurf) {
        iconTex = SDL_CreateTextureFromSurface(renderer, iconSurf);
        SDL_FreeSurface(iconSurf);
    }

    bool running = true;
    int frame = 0;

    while (running) {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) running = false;
        }

        SDL_SetRenderDrawColor(renderer, 135, 206, 235, 255); // cielo
        SDL_RenderClear(renderer);

        // Suelo verde
        SDL_Rect ground = {0, 400, 1280, 320};
        SDL_SetRenderDrawColor(renderer, 34, 139, 34, 255);
        SDL_RenderFillRect(renderer, &ground);

        // Capibara icono centro
        if (iconTex) {
            SDL_Rect dst = {540, 250, 200, 200};
            SDL_RenderCopy(renderer, iconTex, NULL, &dst);
        }

        SDL_RenderPresent(renderer);
        frame++;

        if (frame % 300 == 0) {
            WHBLogPrintf("Frame %d", frame);
        }
    }

    if (iconTex) SDL_DestroyTexture(iconTex);
    IMG_Quit();
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    WHBLogUdpDeinit();
    return 0;
}
