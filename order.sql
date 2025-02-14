-- Create the categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    display_order INT
);

-- Create the dietary_tags table
CREATE TABLE dietary_tags (
    tag_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- Create the wines table
CREATE TABLE wines (
    wine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    year INT,
    description TEXT
);

-- Create the menu_items table
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    is_chef_recommended BOOLEAN DEFAULT FALSE,
    wine_pairing_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (wine_pairing_id) REFERENCES wines(wine_id)
);

-- Create junction table for menu items and dietary tags (many-to-many relationship)
CREATE TABLE menu_item_dietary_tags (
    item_id INT,
    tag_id INT,
    PRIMARY KEY (item_id, tag_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id),
    FOREIGN KEY (tag_id) REFERENCES dietary_tags(tag_id)
);

-- Insert sample categories
INSERT INTO categories (name, display_order) VALUES
('Starters', 1),
('Main Course', 2),
('Desserts', 3);

-- Insert sample dietary tags
INSERT INTO dietary_tags (name) VALUES
('Vegetarian'),
('Gluten-Free'),
('Signature');

-- Insert sample wines
INSERT INTO wines (name, year, description) VALUES
('Château Lafite Rothschild', 2010, 'Premier Cru Bordeaux with exceptional depth and complexity');

-- Insert sample menu items
INSERT INTO menu_items (name, description, price, category_id, is_chef_recommended, wine_pairing_id, image_url) VALUES
('Wagyu A5 Striploin', 'Japanese A5 Wagyu striploin, truffle potato purée, seasonal mushrooms, red wine reduction', 180.00, 2, TRUE, 1, 'images/dishes/wagyu.jpg');

-- Link menu items with dietary tags
INSERT INTO menu_item_dietary_tags (item_id, tag_id)
SELECT 
    (SELECT item_id FROM menu_items WHERE name = 'Wagyu A5 Striploin'),
    tag_id 
FROM dietary_tags 
WHERE name IN ('Gluten-Free', 'Signature');
