#include <iostream>
#include <cstdlib>
#include <string>
#include <math.h>
#include <SFML/Audio.hpp>
#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
using namespace std;

using namespace sf;

typedef struct {
	float ox;
	float oy;
	float x;
	float y;
	int dir;
	int en;
	Sprite sprite;
	IntRect* rect;
} bullet;

typedef struct {
	int en;
	float x;
	float y;
	Sprite sprite;
	float hp;
	int line;
	int type;
	IntRect* rect;
} mnst;




typedef struct{
	int en;
	bullet b;
	float x;
	float y,py;
	int c, key,chat;
	float wy;
	int der,f;
	Sprite sprite;
	float hp;
	int line;
	int dir;
	mnst* m;
	int bats;
	IntRect *rect;
} character;

void init_m( mnst* m, int n) {
	for (int i = 0; i < n; i++) {
		m[i].en=0;
		m[i].x=0;
		m[i].y=0;
		m[i].sprite;
		m[i].hp=2;
		m[i].line=0;
		IntRect rekt(0,0,32,32);
		m[i].rect=&rekt;
	}

}
void spawn_m(character* MC,mnst* m, int n,int type,RenderWindow* window) {
	
	for (int i = 0; i < n; i++) {
		if (m[i].en == 0) {
			m[i].sprite.setColor(Color::White);
			m[i].en = 1;
			do {
				m[i].x = rand() % window->getSize().x;
				m[i].y = rand() % window->getSize().y;
			} while (abs(m[i].x - MC->x) < 100 || abs(m[i].y - MC->y) < 100);
			m[i]. type = type;
			m[i].hp = 2;
			break;
		}
		
	}
}

void move_m(character* MC,mnst* m, int n, double delta, RenderWindow * window) {
	float j,k;
	
	for (int i = 0; i < n; i++) {
		if (m[i].en == 1) {
			j = MC->x - m[i].x;
			k = MC->y * window->getSize().y / 600.0 - m[i].y;
			m[i].x = m[i].x + (j / abs(j))*5 / delta;
			m[i].y = m[i].y + (k / abs(k) *5/ delta);
			m[i].sprite.setPosition(m[i].x * window->getSize().x / 800.0, m[i].y+MC->py);
		}
	}
}

void character_initializer(character* char_obj, string type, int x, int y){
	char_obj->m = new mnst[10];
	init_m(char_obj->m, 10);
	char_obj->chat = -1;
	char_obj->hp = 3;
	char_obj->x = x;
	char_obj->f = 0;
	char_obj->c = 0;
	char_obj->key = 0;
	char_obj->en = 1;
	char_obj->wy = y;
	char_obj->bats = 0;
	char_obj->y = y;
	char_obj->dir = 1;
	char_obj->der = 1;
	IntRect rectangular(0, 0, 32, 32);
	IntRect rectangular_shape(0, 0, 32, 32);
	char_obj->b.rect = &rectangular;
	char_obj->rect = &rectangular_shape;
	char_obj->sprite.setOrigin(-200, 16);
	char_obj->line = 0;
	char_obj->sprite.setOrigin(32 / 2, 32 / 2);
	char_obj->b.en = 0;
}

void spawn_b(character * MC) {
	if (MC->b.en == 0) {
		MC->b.ox = MC->sprite.getPosition().x;
		MC->b.oy = MC->y;
		if(MC->f==1)
			MC->b.dir =3;
		else if (MC->der == 1 && MC->dir == 1) {
			MC->b.dir = 0;
		}
		else if (MC->der == 1) {
			MC->b.dir = 1;
		}
		else if (MC->dir == -1) {
			MC->b.dir = 2;
		}
		if(MC->f==0){
		MC->b.x = MC->b.ox - MC->b.dir * 30;
		MC->b.y = MC->b.oy - (1 - MC->der) * 30;
		}else{
			MC->b.x = MC->b.ox -60 ;
			MC->b.y = MC->b.oy + 2 * 30;
		}
		MC->b.en = 1;
		float var = MC->sprite.getPosition().y - MC->b.y - MC->py;
		MC->b.y = MC->b.y + var + MC->py;
		MC->b.sprite.setPosition(MC->b.x, MC->b.y);
	}
}

void move_b(character * MC, double delta) {
	if (MC->b.en == 1) {
		switch (MC->b.dir) {
		case 0:
			MC->b.x = MC->b.x + 50 / delta;
			break;
		case 1:
			MC->b.x = MC->b.x - 50 / delta;
			break;
		case 2:
			MC->b.y = MC->b.y - 50 / delta;
			break;
		case 3:
			MC->b.y = MC->b.y + 50 / delta;
			break;
		}
		MC->b.sprite.setPosition(MC->b.x, MC->b.y);
	}
}

void destroy_b(character* MC, mnst* m, int n,double delta, RenderWindow* window) {
	float w = MC->b.y;
	if (MC->b.x < -15 || MC->b.x > window->getSize().x)
		MC->b.en = 0;
	if (w < -15||w>(int)window->getSize().y)
		MC->b.en = 0;
	for (int i = 0; i < n; i++) {
		if (abs(m[i].sprite.getPosition().x - MC->b.sprite.getPosition().x) < 150 && abs(m[i].sprite.getPosition().y - MC->b.sprite.getPosition().y) < 50 && m[i].en == 1 && MC->b.en == 1) {
			MC->b.en = 0;
			m[i].sprite.setColor(Color::Red);
			m[i].hp = m[i].hp - 1;
			if (m[i].hp <= 0) {
				m[i].en = 0;
				MC->c = MC->c + 1;
			}
		}
		if (abs(m[i].sprite.getPosition().x - MC->sprite.getPosition().x) < 50 && abs(m[i].sprite.getPosition().y - MC->sprite.getPosition().y) < 50 && m[i].en == 1 && MC->en == 1)
			MC->en = 0;
	}
	}

int cutscene(Clock clock,IntRect* rectSourceSprite, Sprite* sprite, int sizex, int sizey, int frames, int line ,int fps) {
	if (((int)(clock.getElapsedTime().asMilliseconds() / (1000.0 / fps))) % (int)sizex < frames) {
		(*rectSourceSprite).left = ((int)(clock.getElapsedTime().asMilliseconds() / (1000.0 / fps))) % (int)frames * sizex;
		(*rectSourceSprite).top = line * sizey;
		(*sprite).setTextureRect(*rectSourceSprite);
		return 1;
	}

	return 0;
}

void animate(Clock clock, IntRect* rectSourceSprite, Sprite* sprite, int sizex,int sizey, int frames, int line, int fps) {
	(*rectSourceSprite).left = ((int)(clock.getElapsedTime().asMilliseconds() / (1000.0 / fps))) % (int)frames * sizex ;
	(*rectSourceSprite).top = line * sizey;
	(*sprite).setTextureRect(*rectSourceSprite);
}

void write(int n, RenderWindow* window,float size, Color c,float x, float y,int i,string str) {
	Font font;
	if (!font.loadFromFile("fonts/pc98.ttf")) {
		cout << "Error loading fonts" << endl;
		//scanf("%*c");
	}
	Text texto;
	texto.setFont(font);
	texto.setFillColor(c);
	texto.setPosition((*window).getSize().x /800*x, (*window).getSize().y /600*y);
	texto.setCharacterSize((*window).getSize().y * size);
	string s = std::to_string(i);

	switch (n)
	{
	case 0:
		texto.setString(s);
		break;
	case 1:
		texto.setString(str);
		break;
	default:
		texto.setString(" ");
	}

	(*window).draw(texto);
}

void chat(int n, RenderWindow* window) {
	switch (n) {
	case 0:
		write(1, window, 0.03, Color::White, 200, 100, 10, "Bem vindo a Dungeon, aqui eh um lugar onde voce pode obter tudo,\n e ao mesmo tempo, perder tudo\n pressione SPACE por sua conta e risco");
		break;
	case 2:
		write(1, window, 0.03, Color::White, 200, 650, 10, "-Nossa! O que aconteceu com meus poderes de cura?\n Talvez eu possa usar minhas novas habilidades nessa dungeon…");
		break;
	case 4:
		write(1, window, 0.03, Color::White, 200, 100, 10, "Vendedor: Olá! O que faz por aqui?\n Aposto que veio em busca do Santo Graal!\n Compre alguma coisa, lá dentro é perigoso, você vai precisar de um item." );
		break;
	case 6:
		write(1, window, 0.03, Color::White, 200, 100, 10, "-Hey! Isso é meio suspeito…");
		break;
	case 8:
		write(1, window, 0.08, Color::White, 200, 650, 10, "Healer: Então era você o tempo todo!");
		break;
	case 10:
		write(1, window, 0.03, Color::White, 200, 100, 10, "Boss: Conseguiu adivinhar? Hahahaha! Já era hora de você morrer!");
		break;
	/*case 101:
		write(1, window, 0.03, Color::White, 350, 650, 10, " vamos, filho");
		break;
	case 102:
		write(1, window, 0.03, Color::White, 350, 650, 10, " vamos, filho\n sua m�e est� nos esperando em casa\n estavamos ansiosos por sua alta");
		break;
	case 103:
		write(1, window, 0.03, Color::White, 350, 650, 10, " estavamos ansiosos por sua alta\n n�o precisa ter medo, estou aqui");
		break;
	case 104:
		write(1, window, 0.03, Color::White, 350, 650, 10, " estavamos ansiosos por sua alta\n n�o precisa ter medo, estou aqui");
		break;
	case 100:
		write(1, window, 0.03, Color::White, 350, 650, 10, "algu�m pode iluminar?");
		break;*/
	default:
		write(1, window, 0.03, Color::White, 50, 650, 10, "");
		break;
	}
}

void draw_menu(int* reset, int* current_scr, Clock true_clock, Clock* clock, Texture * textures ,RenderWindow *window) {
	// Create text
	IntRect rec(0,0,800,600);

	// BG
	Texture bg_texture;
	if (!bg_texture.loadFromFile("img/bg_menu.png", sf::IntRect(0, 0, 256, 128))) {
		perror("failed to load bg image");
		//scanf("%*c");
	}
	Sprite bg_menu(bg_texture);
	bg_menu.scale((*window).getSize().x/248.2, (*window).getSize().y/128);
	bg_menu.setPosition(0, 0);

	// Tutorial
	IntRect key_rect(0,0,64,64);
	Sprite keys(textures[11], key_rect);
	keys.scale((*window).getSize().x/400, (*window).getSize().x/400);
	keys.setPosition((*window).getSize().x - keys.getGlobalBounds().width, (*window).getSize().y - keys.getGlobalBounds().width);
	animate(true_clock, &key_rect, &keys, 64, 64, 11, 0, 2);

	// Text1
	Texture logo_texture;
	if (!logo_texture.loadFromFile("img/healers.png", sf::IntRect(0, 0, 1600, 64))) {
		perror("failed to load logo image");
		//scanf("%*c");
	}
	IntRect logo_rect(0,0,64,64);
	Sprite logo(logo_texture);
	logo.setTextureRect(logo_rect);
	logo.scale((*window).getSize().x/164, (*window).getSize().y/164);
	logo.setPosition((*window).getSize().x/2-logo.getGlobalBounds().width/2, (*window).getSize().y/2/2-logo.getGlobalBounds().height/2);

	//Text2
	Texture logo2_texture;
	if (!logo2_texture.loadFromFile("img/tale.png", sf::IntRect(0, 0, 1632, 96))) {
		perror("failed to load logo2 image");
		//scanf("%*c");
	}
	IntRect logo2_rect(0,0,96,96);
	Sprite logo2(logo2_texture);
	logo2.setTextureRect(logo2_rect);
	logo2.scale((*window).getSize().x/220, (*window).getSize().y/220);
	logo2.setPosition((*window).getSize().x/2-logo2.getGlobalBounds().width/2, (*window).getSize().y/2/2-logo.getGlobalBounds().height/2);
	if(*reset==0){
		clock->restart();
		*reset=1;
	}

	if(*reset==1){
		animate(*clock, &logo_rect, &logo, 64, 64, 25, 0, 10);
		if(!cutscene(*clock, &logo2_rect, &logo2, 96, 96, 17, 0, 25/17*10))
			*reset=3;
	}else if(*reset ==3){
		logo_rect.left=64*24;
		logo2_rect.left=96*16;
		logo.setTextureRect(logo_rect);
		logo2.setTextureRect(logo2_rect);
	}

	Font font;
	if (!font.loadFromFile("fonts/pc98.ttf")) {
		cout << "Error loading fonts" << endl;
		//scanf("%*c");
	}
	Text opt1;
	Text opt2;
	Text opt3;
	opt1.setFont(font);
	opt2.setFont(font);
	opt3.setFont(font);
	opt1.setString("Iniciar");
	opt2.setString("Creditos");
	opt3.setString("Sair");
	opt1.setCharacterSize((*window).getSize().y * 0.05);
	opt2.setCharacterSize((*window).getSize().y * 0.05);
	opt3.setCharacterSize((*window).getSize().y * 0.05);
	//logo.setPosition((*window).getSize().x / 2 - ((*window).getSize().y * 0.08 * 21) / 2 / 2, (*window).getSize().y / 2 / 2 - (*window).getSize().y * 0.08 / 2);
	opt1.setPosition((*window).getSize().x * 0.02, (*window).getSize().y * 0.5 + (*window).getSize().y * 0.08 * 3);
	opt2.setPosition((*window).getSize().x * 0.02, (*window).getSize().y * 0.5 + (*window).getSize().y * 0.08 * 4);
	opt3.setPosition((*window).getSize().x * 0.02, (*window).getSize().y * 0.5 + (*window).getSize().y * 0.08 * 5);

	// Menu events
	if (opt1.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		opt1.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left))
			* current_scr = 1;
	}
	else if (opt2.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		opt2.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left))
			* current_scr = 2;
	}
	else if (opt3.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		opt3.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left))
			(*window).close();
	}else if(logo.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)|| logo2.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		logo2.setColor(Color::Magenta);
		logo.setColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left))
			* reset=0;
	}

	// Draw
	//(*window).draw(menu);
	(*window).draw(bg_menu);
	(*window).draw(opt1);
	(*window).draw(opt2);
	(*window).draw(opt3);
	(*window).draw(logo);
	(*window).draw(logo2);
	(*window).draw(keys);
}

void draw_gameover(int* reset,Clock clock,int* current_scr, Texture* textures, RenderWindow* window) {
	Font font;
	if (!font.loadFromFile("fonts/pc98.ttf")) {
		cout << "Error loading fonts" << endl;
		//scanf("%*c");
	}
	IntRect die(0, 0, 300, 300);
	Sprite died(textures[0], die);
	died.setPosition((*window).getSize().x/2-died.getGlobalBounds().width/2, (*window).getSize().y/2-died.getGlobalBounds().height/2);
	//died.setScale((*window).getSize().x/300.0, (*window).getSize().y / 300.0);
	//animate(clock, &die, &died, 800, 600, 4, 0, 10);
	(*window).draw(died);

	Text gameover;
	gameover.setFont(font);
	gameover.setString("Voce Perdeu\n  o Jogo!");
	gameover.setCharacterSize((*window).getSize().y * 0.08);
	gameover.setPosition((*window).getSize().x / 2 - gameover.getGlobalBounds().width / 2, (*window).getSize().y / 2 / 2 / 2);
	Text menu;
	menu.setFont(font);
	menu.setString("Voltar ao menu");
	menu.setCharacterSize((*window).getSize().y * 0.05);
	menu.setPosition((*window).getSize().x / 2 + 50, (*window).getSize().y / 2 / 2 * 3);
	Text retry;
	retry.setFont(font);
	retry.setString("Tentar novamente");
	retry.setCharacterSize((*window).getSize().y * 0.05);
	retry.setPosition((*window).getSize().x / 2 - 50 - retry.getGlobalBounds().width, (*window).getSize().y / 2 / 2 * 3);

	// Menu events
	if (menu.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		menu.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left)) {
			*current_scr = 0;
		
		}
	}
	else if (retry.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		retry.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left)) {
			*current_scr = 1;
		}
	}

	(*window).draw(gameover);
	(*window).draw(menu);
	(*window).draw(retry);
}

void draw_credits_gamso(RenderWindow *window) {
	// Create text
	Font font;
	if (!font.loadFromFile("fonts/pc98.ttf")) {
		cout << "Error loading fonts" << endl;
		//scanf("%*c");
	}
	Text credits;
	credits.setFont(font);
	credits.setString("Produzido por Lunare Team e");
	credits.setCharacterSize((*window).getSize().y*0.05);
	credits.setPosition((*window).getSize().x/2-credits.getGlobalBounds().width/2, (*window).getSize().y*0.02);

	// Create texture
	Texture texture;
	if (!texture.loadFromFile("img/gamso.png")){
		cout << "Error loading texture" << endl;
	}
	texture.setSmooth(false);
	Sprite sprite;
	sprite.setTexture(texture);
	sprite.setScale(((*window).getSize().y - 200) / sprite.getLocalBounds().width, ((*window).getSize().y - 200) / sprite.getLocalBounds().height);
	sprite.setPosition((*window).getSize().x/2-sprite.getGlobalBounds().width/2, (*window).getSize().y/2-sprite.getGlobalBounds().height/2);

	(*window).draw(credits);
	(*window).draw(sprite);
}

void draw_credits(int* current_scr, Texture* textures, RenderWindow *window) {
	// Create text
	Font font;
	if (!font.loadFromFile("fonts/pc98.ttf")) {
		cout << "Error loading fonts" << endl;
		//scanf("%*c");
	}
	IntRect voltar_rect(0,0,32,32);
	Sprite voltar;
	voltar.setTextureRect(voltar_rect);
	voltar.setTexture(textures[2]);
	voltar.setScale((*window).getSize().x*0.002,(*window).getSize().x*0.002);
	voltar.setPosition((*window).getSize().x*0.0001, (*window).getSize().x*0.0001);
	Text credits;
	credits.setFont(font);
	credits.setString("Joao Bueno\nMatheus Ramos\nGabriel Penajo\nIsabela Magalhaes");
	credits.setCharacterSize((*window).getSize().y * 0.05);
	credits.setPosition((*window).getSize().x/2-credits.getGlobalBounds().width/2, (*window).getSize().y/2-credits.getGlobalBounds().height/2);

	// Mouse events
	if (voltar.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		voltar.setColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left))
			* current_scr = 0;
	}

	// Draw
	(*window).draw(voltar);
	(*window).draw(credits);
}

typedef struct{
	double x;
	double y;
} Door;

void draw_game(Door* door, int* map, character* MC, Sound sound[], Texture* textures, double delta, Clock clock, int* current_scr, RenderWindow* window, Event event) {

	if(*map>=9){
		*current_scr = 4;
	}
	if (MC->c >= *map * 2 * (*map))
		MC->key = 1;


	Sprite map_sprite;
	IntRect door_rec(0,0,32,32);
	Sprite door_sprite(textures[12], door_rec);
	door_sprite.setScale((*window).getSize().x/300, (*window).getSize().x/300);
	
	door_sprite.setPosition(door->x, door->y+MC->py);

	IntRect map_rec(0, 0, 64, 64);
	if (Keyboard::isKeyPressed(Keyboard::Space) && *map < 1 ) {
		*map = *map + 1;
		init_m(MC->m, 10);
	}
	MC->bats=1;

	if (*map>0&&(MC->bats && (0 == ((int ) clock.getElapsedTime().asMilliseconds() )% 60))) {
		spawn_m(MC,MC->m, 10, 1, window);
	}
	move_m(MC, MC->m, 10, delta,window);

	IntRect rec(0, 0, 32, 32);
	MC->b.sprite.setTextureRect(rec);
	MC->b.sprite.setTexture(textures[6]);

	for (int i = 0; i < 10; i++) {
		animate(clock, &rec, &MC->m[i].sprite, 32, 32, 4, 0, 10);
		MC->m[i].sprite.setTexture(textures[4]);
		MC->m[i].sprite.setTextureRect(rec);
	}

	int var = 0, vel = 7;

	MC->sprite.setTextureRect(rec);
	move_b(MC, delta);
	destroy_b(MC,MC->m ,10,delta, window);
	MC->sprite.setPosition((MC->x) * (*window).getSize().x / 800.0, (MC->wy) * (*window).getSize().y / 600.0);
	MC->sprite.setScale((*window).getSize().x / 400.0, (*window).getSize().y / 300.0);
	MC->b.sprite.setScale((*window).getSize().x / 700.0, (*window).getSize().y / 700.0);
	MC->sprite.setTexture(textures[3]);
	animate(clock, (&rec), &(MC->sprite), 32, 32, 4, 0, 10);
	animate(clock, &rec, &MC->b.sprite, 32, 32, 3, 0, 10);

	int s = (*window).getSize().x, ss = (*window).getSize().y;

	if (MC->y * (*window).getSize().y / 600.0 < (*window).getSize().y / 2.0) {
		MC->wy = MC->y;
		MC->py = 0;
		map_sprite.setPosition(0, 0);
		MC->sprite.setPosition((MC->x) * (*window).getSize().x / 800.0, (MC->wy) * (*window).getSize().y / 600.0);
	}
	else if (MC->y * (*window).getSize().y / 600.0 > (*window).getSize().y / 2.0 + ((*window).getSize().x - (*window).getSize().y)) {
		MC->py = ss - s;
		MC->wy = (((MC->y) * ss / 600.0) + (ss - s)) / ss / 600.0;
		map_sprite.setPosition(0, ss - s);
		MC->sprite.setPosition((MC->x) * s / 800.0, (((MC->y) * ss / 600.0) + (ss - s)));
	}
	else {
		MC->wy = (ss / 2.0) / (ss / 600.00);
		MC->py = (*window).getSize().y / 2 - MC->y * (*window).getSize().y / 600;
		map_sprite.setPosition(0, (*window).getSize().y / 2 - MC->y * (*window).getSize().y / 600);
		MC->sprite.setPosition((MC->x) * s / 800.0, ss / 2.0);
	}

	if (Keyboard::isKeyPressed(Keyboard::W) && MC->y > 134) {
		MC->y = (MC->y) - vel / delta;
		MC->sprite.setTexture(textures[9]);
		MC->der = -1;
		MC->dir = -1;
		MC->f=0;

	}
	else if (Keyboard::isKeyPressed(Keyboard::S) && MC->y < 964) {
		(MC->y) = (MC->y) + vel / delta;
		MC->sprite.setTexture(textures[3]);
		MC->der = 1;
		MC->f=1;
	}else {
		var = 1;
	}

	if (MC->der == -1)
		MC->sprite.setTexture(textures[9]);


	else
		MC->sprite.setTexture(textures[3]);

	if (Keyboard::isKeyPressed(Keyboard::D) && MC->x < 726) {
		(MC->x) = (MC->x) + vel / delta;
		MC->der = 1;
		MC->f=0;
		var = 0;
		if (MC->dir != 1) {
			MC->dir = 1;
		}
	}
	else if (Keyboard::isKeyPressed(Keyboard::A) && MC->x > 124) {
		(MC->x) = (MC->x) - vel / delta;
		MC->der = 1;
		MC->f=0;
		var = 0;
		if (MC->dir != -1) {
			MC->dir = -1;
		}
	}
	else {
		
	}

	if(MC->sprite.getGlobalBounds().intersects(door_sprite.getGlobalBounds()) && *map >=1&& MC->key ==1){
		*map = *map + 1;
		init_m(MC->m, 10);
		MC->key = 0;
	}

	else if (var == 1) {
		rec.left = 32;
		if(MC->f==1&&Keyboard::isKeyPressed(Keyboard::Space) ){
			MC->sprite.setTexture(textures[10]);
			spawn_b(MC);
		}
		else if (Keyboard::isKeyPressed(Keyboard::Space) && MC->der == 1) {
			MC->sprite.setTexture(textures[8]);
			rec.left = 0;
			spawn_b(MC);
		}
		else if (Keyboard::isKeyPressed(Keyboard::Space) && MC->der == -1) {
			MC->sprite.setTexture(textures[9]);
			rec.left = 0;
			spawn_b(MC);
		}
		MC->sprite.setTextureRect(rec);

	}

	MC->sprite.scale(MC->dir, 1);
	if (MC->der == -1)
		MC->b.sprite.scale(0.5, 1);

	map_sprite.setTextureRect(map_rec);
	map_sprite.setTexture(textures[7]);
	map_sprite.setScale(13 * (*window).getSize().x / 800, 13 * (*window).getSize().x / 800);

	switch (*map) {
	case 0:
		MC->chat = 0;
		//Bem vindo ao jogo, atire com a tecla espaço
		map_sprite.setColor(Color::Magenta);
		break;
	case 1:
		//
		map_sprite.setColor(Color::Magenta);
		MC->chat = 0;
		break;
	case 2:
		MC->chat = 1;
		map_sprite.setColor(Color::Green);
		break;
	case 3:
		map_sprite.setColor(Color::Cyan);
		break;
	case 4:
		map_sprite.setColor(Color::Magenta);
		break;
	case 5:
		map_sprite.setColor(Color::Red);
		break;
	case 6:
		map_sprite.setColor(Color::Red);
		break;
	case 7:
		map_sprite.setColor(Color::Green);
		break;
	case 8:
		map_sprite.setColor(Color::Cyan);
		break;
	default:
		break;
	}

	if(*map<1){
		door_sprite.setPosition((*window).getSize().x+200, (*window).getSize().y+200);
	}

	(*window).draw(map_sprite);
	(*window).draw(door_sprite);

	if (MC->b.en == 1)
		for (int i = 1; i < 10; i++){
			MC->b.sprite.setPosition(MC->b.x - i * 0.5 *25* (MC->b.dir == 1 ? 1 : -2), MC->b.y + i * 0.5 * 10*((MC->b.dir == 1 ? 0.1*i : i%2)));
			MC->b.sprite.scale( 0.12*(10-i), (10- i)*0.12);
			MC->b.sprite.setColor(Color(255, 255, 255, 255 - i * 20));
			(*window).draw(MC->b.sprite);
		}
	(*window).draw(MC->sprite);
	for(int i=0;i<10;i++)
		if(MC->m[i].en==1)
			window->draw(MC->m[i].sprite);
	if (MC->en == 0) {
		*current_scr = 3;
		init_m(MC->m, 10);
		character_initializer(MC, "mc", 200, 200);
	}
	if (*map <= 2) {
		IntRect key_rect(0, 0, 64, 64);
		Sprite keys(textures[11], key_rect);
		keys.scale((*window).getSize().x / 400, (*window).getSize().x / 400);
		keys.setPosition((*window).getSize().x - keys.getGlobalBounds().width, (*window).getSize().y - keys.getGlobalBounds().width);
		animate(clock, &key_rect, &keys, 64, 64, 11, 0, 2);
		window->draw(keys);

	}
	chat(MC->chat, window);
	if (MC->key == 1 && *map!=0)
		write(1, window, 0.03, Color::White, 400, 300, 10, "VOSSAMERCE TENS A CHAVE!\n  CORRA IMEDIATAMENTE PARA A PORTA!");
	//write(0, window, 10, Color::White, 100, 700, MC->c, "");
}

void draw_win(Clock clock,int* current_scr, Texture* textures, RenderWindow* window) {
	Font font;
	if (!font.loadFromFile("fonts/pc98.ttf")) {
		cout << "Error loading fonts" << endl;
		//scanf("%*c");
	}
	IntRect die(0, 0, 300, 300);
	Sprite died(textures[0], die);
	died.setPosition((*window).getSize().x/2-died.getGlobalBounds().width/2, (*window).getSize().y/2-died.getGlobalBounds().height/2);
	//died.setScale((*window).getSize().x/300.0, (*window).getSize().y / 300.0);
	//animate(clock, &die, &died, 800, 600, 4, 0, 10);
	(*window).draw(died);

	Text gameover;
	gameover.setFont(font);
	gameover.setString("Voce Ganhou\n  o Jogo!");
	gameover.setCharacterSize((*window).getSize().y * 0.08);
	gameover.setPosition((*window).getSize().x / 2 - gameover.getGlobalBounds().width / 2, (*window).getSize().y / 2 / 2 / 2);
	Text menu;
	menu.setFont(font);
	menu.setString("Voltar ao menu");
	menu.setCharacterSize((*window).getSize().y * 0.05);
	menu.setPosition((*window).getSize().x / 2 + 50, (*window).getSize().y / 2 / 2 * 3);
	Text retry;
	retry.setFont(font);
	retry.setString("Jogar novamente");
	retry.setCharacterSize((*window).getSize().y * 0.05);
	retry.setPosition((*window).getSize().x / 2 - 50 - retry.getGlobalBounds().width, (*window).getSize().y / 2 / 2 * 3);

	// Menu events
	if (menu.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		menu.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left))
			* current_scr = 0;
	}
	else if (retry.getGlobalBounds().contains(Mouse::getPosition(*window).x, Mouse::getPosition(*window).y)) {
		retry.setFillColor(Color::Magenta);
		if (Mouse::isButtonPressed(Mouse::Left)) {
			*current_scr = 1;
		}
	}

	(*window).draw(gameover);
	(*window).draw(menu);
	(*window).draw(retry);
}

void draw_scr(Door* door, int* reset, Clock* cut_clock, int* map, character* MC, Texture* textures, double delta, Clock clock, int* current_scr, RenderWindow* window, Event& event, Sound sound[]) {
	/*
	 *  0 - Menu
	 *  1 - Game
	 *  2 - Credits
	 *  3 - Game Over Yeah
	 */

	switch (*current_scr) {
	case 0:
		draw_menu(reset, current_scr, clock, cut_clock, textures, window);
		break;
	case 1:
		draw_game(door, map, MC,sound, textures,delta, clock, current_scr, window, event);
		break;
	case 2:
		draw_credits(current_scr, textures, window);
		break;
	case 3:
		draw_gameover(reset,clock,current_scr, textures,window);
		break;
	case 4:
		draw_win(clock,current_scr, textures,window);
		break;
	default:
		break;
	}
}

Texture* load_textures() {
	/*
	 *  0 - Game Over , 300 300 1 1
	 *  1 - Cursor    , 32  32  1 2
	 *  2 - Arrow     , 32  32  1 1
	 *  3 - MC        , 32  32  4 1
	 *  4 - Bat       , 32  32  6 1
	 *  5 - Butterfly , 32  32  6 1
	 *  6 - Heal      , 32  32  3 1
	 *  7 - Dungeon   , 64  64  1 1
	 *  8 - Pawa      , 32  32  1 1
	 *  9 - back      , 32  32  4 1
	 */

	Texture *textures;
	textures=(Texture*)malloc(sizeof(Texture) * 13);

	Texture gameover;
	if (!gameover.loadFromFile("img/gameover.jpg", sf::IntRect(0, 0, 300, 300))) {
		perror("failed to load gameover image");
		//scanf("%*c");
	}
	Texture cursor;
	if (!cursor.loadFromFile("img/cursor.png", sf::IntRect(0, 0, 32, 64))) {
		perror("failed to load cursor image");
		//scanf("%*c");
	}
	Texture back_arrow;
	if (!back_arrow.loadFromFile("img/arrow.png", sf::IntRect(0, 0, 32, 32))) {
		perror("failed to load back_arrow image");
		//scanf("%*c");
	}
	Texture mc;
	if (!mc.loadFromFile("img/mc.png", sf::IntRect(0, 0, 128, 32))) {
		perror("failed to load mc image");
		//scanf("%*c");
	}
	Texture bat;
	if (!bat.loadFromFile("img/bat.png", sf::IntRect(0, 0, 192, 32))) {
		perror("failed to load bat image");
		//scanf("%*c");
	}
	Texture butterfly;
	if (!butterfly.loadFromFile("img/samurai.png", sf::IntRect(0, 0, 192, 32))) {
		perror("failed to load samurai image");
		//scanf("%*c");
	}
	Texture heal;
	if (!heal.loadFromFile("img/heal.png", sf::IntRect(0, 0, 96, 32))) {
		perror("failed to load heal image");
		//scanf("%*c");
	}
	Texture dungeon;
	if (!dungeon.loadFromFile("img/initialdungeon.png", sf::IntRect(0, 0, 64, 64))) {
		perror("failed to load dungeon image");
		//scanf("%*c");
	}
	Texture pawa;
	if (!pawa.loadFromFile("img/pawa.png", sf::IntRect(0, 0, 32, 32))) {
		perror("failed to load kono pawa image");
		//scanf("%*c");
	}
	Texture back;
	if (!back.loadFromFile("img/persona.png", sf::IntRect(0, 0, 4*32, 32))) {
		perror("failed to load kono pawa image");
		//scanf("%*c");
	}
	Texture front;
		if (!front.loadFromFile("img/mc_front.png", sf::IntRect(0, 0, 128, 32))) {
			perror("failed to load kono pawa image");
			//scanf("%*c");
	}
	Texture key;
	if (!key.loadFromFile("img/keys.png", sf::IntRect(0, 0, 704, 64))) {
		perror("failed to load keys image");
		//scanf("%*c");
	}
	Texture door;
	if (!door.loadFromFile("img/door.png", sf::IntRect(0, 0, 32, 32))) {
		perror("failed to load door image");
		//scanf("%*c");
	}

	textures[0]  = gameover;
	textures[1]  = cursor;
	textures[2]  = back_arrow;
	textures[3]  = mc;
	textures[4]  = bat;
	textures[5]  = butterfly;
	textures[6]  = heal;
	textures[7]  = dungeon;
	textures[8]  = pawa;
	textures[9]  = back;
	textures[10] = front;
	textures[11] = key;
	textures[12] = door;
	return textures;

}

void reset_door(Door* door, RenderWindow* window){
	door->x = (*window).getSize().x/7 + ( std::rand() % ( (*window).getSize().x/7*5 - (*window).getSize().x/7 + 1 ) );
	door->y = (*window).getSize().y/5 + ( std::rand() % ( (*window).getSize().x/5*4 - (*window).getSize().x/5 + 1 ) );
}

int main(void) {
	int current_scr[1] = { 0 };
	int cursor_line = 1, map = 0;
	int reset = 0;

	Door door;

	// Initialize clock
	Clock clock;
	Clock cut_clock;
	// Initialize window
	RenderWindow window(VideoMode::getDesktopMode(), "Healer's Tale", Style::Fullscreen);
	window.setFramerateLimit(60);
	window.setMouseCursorVisible(false);
	Texture* textures;
	textures = load_textures();
	Sprite cursor(textures[1]);
	IntRect cursorRect(0,0,32,32);
	character MC;
	character_initializer(&MC, "mc", 200, 200);
	SoundBuffer walk;
	if (!walk.loadFromFile("sound/walk.wav")) {
		cout << "Error loading sound" << endl;
		//scanf("%*c");
	}
	SoundBuffer bgm;
	if (!bgm.loadFromFile("sound/bgm.ogg")) {
		cout << "Error loading sound" << endl;
		//scanf("%*c");
	}
	SoundBuffer speech;
	if (!speech.loadFromFile("sound/speech.wav")) {
		cout << "Error loading sound" << endl;
		//scanf("%*c");
	}
	Sound sound[4], bg;
	sound[0].setBuffer(walk);
	sound[1].setBuffer(speech);
	bg.setBuffer(bgm);

	double nt,ot=0,delta;
	while( window.isOpen()) {

		Time time;
		time = clock.getElapsedTime();
		nt = time.asMicroseconds();

		delta = 50000/(nt - ot) ;
		Event event;
		while (window.pollEvent(event)){
			if (event.type == Event::Closed)
				window.close();
		}
	
		int old_map = map;
		int old_scr = *current_scr;

		window.clear();
		if (time.asSeconds() <= 2)
			draw_credits_gamso(&window);
		else {
			draw_scr(&door, &reset, &cut_clock, &map, &MC,textures, delta, clock, current_scr, &window, event, sound);
			if (bg.getStatus() != bg.Playing && *current_scr == 1)
				bg.play();
			else if (bg.getStatus() == bg.Playing && *current_scr == 0)
				bg.stop();
		}

		if(old_map!=map){
			reset_door(&door, &window);
		}
		if(old_scr!=*current_scr){
			map=0;
		}


		cursorRect.top = 0;
		cursor.setTextureRect(cursorRect);

		if (Mouse::isButtonPressed(Mouse::Left))
			cursor_line = 0;
		else
			cursor_line = 1;

		cursor.setOrigin(16, 16);
		cursor.setPosition(static_cast<Vector2f>(Mouse::getPosition(window)));
		cursor.setScale((window).getSize().x*0.001, (window).getSize().x*0.001);
		animate(clock, &cursorRect, &cursor, 32, 32, 1, cursor_line, 4);
		window.draw(cursor);
		window.display();
		ot = nt;
	}

	free(textures);
	return 0;

}
