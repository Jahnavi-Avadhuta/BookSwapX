-- ============================================================
-- BookSwapX Database Schema
-- Version: 1.0 (actual working schema)
-- Database: bookswapx
-- ============================================================

CREATE DATABASE IF NOT EXISTS bookswapx;
USE bookswapx;

-- ============================================================
-- TABLE 1: categories
-- ============================================================
CREATE TABLE categories (
    category_id   INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================================
-- TABLE 2: users
-- ============================================================
CREATE TABLE users (
    user_id         INT PRIMARY KEY AUTO_INCREMENT,
    username        VARCHAR(50)  NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,
    location        VARCHAR(100) NOT NULL,
    role            ENUM('USER', 'ADMIN') DEFAULT 'USER',
    profile_picture VARCHAR(255),
    trust_score     DECIMAL(4,2) DEFAULT 0.00,
    is_active       BOOLEAN      DEFAULT TRUE,
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    last_login      TIMESTAMP    NULL
);

-- ============================================================
-- TABLE 3: books
-- ============================================================
CREATE TABLE books (
    book_id          INT PRIMARY KEY AUTO_INCREMENT,
    title            VARCHAR(150) NOT NULL,
    author           VARCHAR(100),
    category_id      INT,
    book_condition   ENUM('NEW', 'GOOD', 'OLD'),
    isbn             VARCHAR(20),
    publication_year YEAR,
    edition          VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ============================================================
-- TABLE 4: listings
-- ============================================================
CREATE TABLE listings (
    listing_id       INT PRIMARY KEY AUTO_INCREMENT,
    user_id          INT,
    book_id          INT,
    type             ENUM('BUY', 'SELL') NOT NULL,
    price            DECIMAL(10,2) DEFAULT 0.00,
    status           ENUM('AVAILABLE', 'PENDING', 'EXCHANGED', 'SOLD') DEFAULT 'AVAILABLE',
    description      TEXT,
    meeting_location VARCHAR(255),
    is_deleted       BOOLEAN   DEFAULT FALSE,
    deleted_at       TIMESTAMP NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- ============================================================
-- TABLE 5: potential_matches
-- Auto-populated by trigger tr_find_mutual_matches
-- ============================================================
CREATE TABLE potential_matches (
    match_id   INT PRIMARY KEY AUTO_INCREMENT,
    user_a_id  INT,
    user_b_id  INT,
    book_a_id  INT,
    book_b_id  INT,
    status     ENUM('PENDING', 'NOTIFIED', 'ACCEPTED', 'REJECTED', 'EXPIRED') DEFAULT 'PENDING',
    match_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NULL,
    FOREIGN KEY (user_a_id) REFERENCES users(user_id),
    FOREIGN KEY (user_b_id) REFERENCES users(user_id),
    FOREIGN KEY (book_a_id) REFERENCES books(book_id),
    FOREIGN KEY (book_b_id) REFERENCES books(book_id)
);

-- ============================================================
-- TABLE 6: exchange_requests
-- ============================================================
CREATE TABLE exchange_requests (
    request_id   INT PRIMARY KEY AUTO_INCREMENT,
    match_id     INT,
    requester_id INT,
    status       ENUM('PENDING', 'ACCEPTED', 'REJECTED', 'COMPLETED') DEFAULT 'PENDING',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responded_at TIMESTAMP NULL,
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (match_id)     REFERENCES potential_matches(match_id),
    FOREIGN KEY (requester_id) REFERENCES users(user_id)
);

-- ============================================================
-- TABLE 7: messages
-- ============================================================
CREATE TABLE messages (
    message_id             INT PRIMARY KEY AUTO_INCREMENT,
    sender_id              INT,
    receiver_id            INT,
    message                TEXT,
    is_read                BOOLEAN   DEFAULT FALSE,
    is_deleted_by_sender   BOOLEAN   DEFAULT FALSE,
    is_deleted_by_receiver BOOLEAN   DEFAULT FALSE,
    sent_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id)   REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

-- ============================================================
-- TABLE 8: reviews
-- ============================================================
CREATE TABLE reviews (
    review_id        INT PRIMARY KEY AUTO_INCREMENT,
    reviewer_id      INT,
    reviewed_user_id INT,
    rating           INT CHECK (rating BETWEEN 1 AND 5),
    comment          TEXT,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_review UNIQUE (reviewer_id, reviewed_user_id),
    FOREIGN KEY (reviewer_id)      REFERENCES users(user_id),
    FOREIGN KEY (reviewed_user_id) REFERENCES users(user_id)
);

-- ============================================================
-- TABLE 9: transaction_history
-- ============================================================
CREATE TABLE transaction_history (
    transaction_id   INT PRIMARY KEY AUTO_INCREMENT,
    listing_id       INT,
    buyer_id         INT,
    seller_id        INT,
    book_id          INT,
    transaction_type ENUM('SALE', 'EXCHANGE') NOT NULL,
    price            DECIMAL(10,2) DEFAULT 0.00,
    is_exchange      BOOLEAN   DEFAULT FALSE,
    completed_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id),
    FOREIGN KEY (buyer_id)   REFERENCES users(user_id),
    FOREIGN KEY (seller_id)  REFERENCES users(user_id),
    FOREIGN KEY (book_id)    REFERENCES books(book_id)
);

-- ============================================================
-- TABLE 10: notifications
-- ============================================================
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT,
    type            ENUM('MATCH_FOUND', 'REQUEST_RECEIVED', 'REQUEST_ACCEPTED', 'NEW_MESSAGE', 'NEW_REVIEW'),
    content         TEXT,
    related_id      INT,
    is_read         BOOLEAN   DEFAULT FALSE,
    read_at         TIMESTAMP NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ============================================================
-- TABLE 11: reports
-- ============================================================
CREATE TABLE reports (
    report_id           INT PRIMARY KEY AUTO_INCREMENT,
    reporter_id         INT,
    reported_user_id    INT NULL,
    reported_listing_id INT NULL,
    reason              ENUM('FAKE_LISTING', 'INAPPROPRIATE', 'SPAM', 'OTHER') NOT NULL,
    description         TEXT,
    status              ENUM('PENDING', 'REVIEWED', 'RESOLVED') DEFAULT 'PENDING',
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reporter_id)         REFERENCES users(user_id),
    FOREIGN KEY (reported_user_id)    REFERENCES users(user_id),
    FOREIGN KEY (reported_listing_id) REFERENCES listings(listing_id)
);

-- ============================================================
-- TABLE 12: wishlist
-- ============================================================
CREATE TABLE wishlist (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id     INT,
    book_id     INT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_wishlist UNIQUE (user_id, book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- ============================================================
-- TABLE 13: admin_actions
-- ============================================================
CREATE TABLE admin_actions (
    action_id    INT PRIMARY KEY AUTO_INCREMENT,
    admin_id     INT,
    action_type  ENUM('DELETE_LISTING', 'BLOCK_USER', 'RESOLVE_REPORT', 'ADD_CATEGORY', 'RESTORE_LISTING'),
    target_table VARCHAR(50),
    target_id    INT,
    description  TEXT,
    performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES users(user_id)
);

-- ============================================================
-- VIEW: user_trust_scores
-- ============================================================
CREATE VIEW user_trust_scores AS
SELECT
    reviewed_user_id,
    AVG(rating)  AS avg_rating,
    COUNT(*)     AS total_reviews
FROM reviews
GROUP BY reviewed_user_id;

-- ============================================================
-- TRIGGER: tr_find_mutual_matches
-- Fires AFTER INSERT on listings
-- Auto-detects mutual exchange opportunities
-- ============================================================
DELIMITER $$

CREATE TRIGGER tr_find_mutual_matches
AFTER INSERT ON listings
FOR EACH ROW
BEGIN
    -- Step 1: Insert all mutual matches
    INSERT INTO potential_matches (user_a_id, user_b_id, book_a_id, book_b_id, status)
    SELECT DISTINCT
        NEW.user_id,
        l2.user_id,
        NEW.book_id,
        l2.book_id,
        'PENDING'
    FROM listings l2
    JOIN listings l3
        ON  l3.user_id  = l2.user_id
        AND l3.type     = 'BUY'
        AND l3.book_id  = NEW.book_id
    JOIN users u1 ON u1.user_id = NEW.user_id
    JOIN users u2 ON u2.user_id = l2.user_id
    WHERE NEW.type       = 'SELL'
      AND l2.type        = 'SELL'
      AND l2.book_id    != NEW.book_id
      AND l2.user_id    != NEW.user_id
      AND l2.status      = 'AVAILABLE'
      AND l3.status      = 'AVAILABLE'
      AND u1.location    = u2.location
      AND EXISTS (
          SELECT 1 FROM listings l4
          WHERE l4.user_id = NEW.user_id
            AND l4.book_id = l2.book_id
            AND l4.type    = 'BUY'
            AND l4.status  = 'AVAILABLE'
      )
      AND NOT EXISTS (
          SELECT 1 FROM potential_matches pm
          WHERE pm.user_a_id = NEW.user_id
            AND pm.user_b_id = l2.user_id
            AND pm.book_a_id = NEW.book_id
            AND pm.book_b_id = l2.book_id
      );

    -- Step 2: Notify each matched user with correct match_id
    INSERT INTO notifications (user_id, type, content, related_id)
    SELECT
        pm.user_b_id,
        'MATCH_FOUND',
        'Perfect match found! Someone wants to exchange with you.',
        pm.match_id
    FROM potential_matches pm
    WHERE pm.user_a_id = NEW.user_id
      AND pm.book_a_id = NEW.book_id
      AND pm.status    = 'PENDING'
      AND pm.match_id  > (
          SELECT COALESCE(MAX(n.related_id), 0)
          FROM notifications n
          WHERE n.user_id = pm.user_b_id
            AND n.type    = 'MATCH_FOUND'
      );

END$$

DELIMITER ;

-- ============================================================
-- PERFORMANCE INDEXES
-- ============================================================
CREATE INDEX idx_listings_status ON listings(status, is_deleted);
CREATE INDEX idx_listings_user   ON listings(user_id);
CREATE INDEX idx_listings_type   ON listings(type);
CREATE INDEX idx_matches_users   ON potential_matches(user_a_id, user_b_id);
CREATE INDEX idx_messages_users  ON messages(sender_id, receiver_id);
CREATE INDEX idx_notifications_user ON notifications(user_id, is_read);

-- ============================================================
-- SAMPLE DATA: Categories (57 categories)
-- ============================================================
INSERT INTO categories (category_name) VALUES
('Fiction'),
('Fantasy'),
('Science Fiction'),
('Mystery'),
('Thriller'),
('Romance'),
('Historical Fiction'),
('Horror'),
('Adventure'),
('Young Adult'),
('Non-Fiction'),
('Biography'),
('Autobiography'),
('History'),
('Philosophy'),
('Religion & Spirituality'),
('Psychology'),
('Self-Help'),
('Personal Development'),
('True Crime'),
('Business & Management'),
('Economics'),
('Politics'),
('Law'),
('Computer Science'),
('Programming'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity'),
('Web Development'),
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('Medical'),
('School Textbooks'),
('Competitive Exams'),
('JEE Preparation'),
('NEET Preparation'),
('UPSC Preparation'),
('Language Learning'),
('Literature'),
('Poetry'),
('Comics'),
('Graphic Novels'),
('Manga'),
('Children''s Books'),
('Picture Books'),
('Educational Kids Books'),
('Cooking'),
('Travel'),
('Health & Fitness'),
('Sports'),
('Photography'),
('Gardening'),
('Dictionaries'),
('Encyclopedias');

-- ============================================================
-- MAKE YOURSELF ADMIN (run after registering)
-- UPDATE users SET role = 'ADMIN' WHERE email = 'your@email.com';
-- ============================================================

-- ============================================================
-- SETUP COMPLETE
-- ============================================================
-- Tables    : 13 (categories, users, books, listings,
--             potential_matches, exchange_requests, messages,
--             reviews, transaction_history, notifications,
--             reports, wishlist, admin_actions)
-- Views     : 1  (user_trust_scores)
-- Triggers  : 1  (tr_find_mutual_matches)
-- Indexes   : 6
-- Categories: 57 inserted
-- ============================================================