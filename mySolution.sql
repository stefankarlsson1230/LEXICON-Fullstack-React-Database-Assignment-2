CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	age INTEGER NOT NULL,
	email TEXT NOT NULL,
	joined DATE NOT NULL
);


CREATE TABLE friends (
	id SERIAL PRIMARY KEY,
	user1_id INTEGER NOT NULL,  	-- The person that sent the friend request
	user2_id INTEGER NOT NULL,		-- The person that accepted the request
	date DATE NOT NULL,				-- When the connection was created

	CONSTRAINT fk_user1_id
		FOREIGN KEY (user1_id)
		REFERENCES users(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_user2_id
		FOREIGN KEY (user2_id)
		REFERENCES users(id)
		ON DELETE CASCADE
);


CREATE TABLE images (
	id SERIAL PRIMARY KEY,
	created_by INTEGER NOT NULL,	-- who uploaded the image	
	image_link TEXT NOT NULL,		-- Link to the image
	about TEXT, 					-- text about the image
	uploaded DATE NOT NULL,			-- when the image was uploaded

	CONSTRAINT fk_creator_id
		FOREIGN KEY (created_by)
		REFERENCES users(id)
		ON DELETE CASCADE
);


CREATE TABLE posts (
	id SERIAL PRIMARY KEY,
	created_by INTEGER NOT NULL,	-- who created the post	
	post_text TEXT NOT NULL,		-- the post text
	post_image INTEGER,				-- links to an image if the post has any
	creation_date DATE NOT NULL,	-- when the post was created

	CONSTRAINT fk_created_by
		FOREIGN KEY (created_by)
		REFERENCES users(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_image
		FOREIGN KEY (post_image)
		REFERENCES images(id)
		ON DELETE CASCADE
);


CREATE TABLE commentaries (
	id SERIAL PRIMARY KEY,
	created_by INTEGER NOT NULL,	-- who made the comment
	post_id INTEGER ,				-- the post the comment is about if not null
	image_id INTEGER,				-- the image the comment is about if not null
	commentary TEXT,				-- the comment

	CONSTRAINT fk_created_by
		FOREIGN KEY (created_by)
		REFERENCES users(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_post
		FOREIGN KEY (post_id)
		REFERENCES posts(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_image
		FOREIGN KEY (image_id)
		REFERENCES images(id)
		ON DELETE CASCADE
);


CREATE TABLE tags (
	id SERIAL PRIMARY KEY,
	tagged_person INTEGER NOT NULL,	-- the user that was tagged
	tagged_by INTEGER NOT NULL,		-- the user that tagged someone
	tagged_post INTEGER NOT NULL,	-- the post that the person was tagged in
	tag_area TEXT, 					-- if existing, a defined area
	
	CONSTRAINT fk_tagged_person
		FOREIGN KEY (tagged_person)
		REFERENCES users(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_tagged_by
		FOREIGN KEY (tagged_by)
		REFERENCES users(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_tagged_post
		FOREIGN KEY (tagged_post)
		REFERENCES posts(id)
		ON DELETE CASCADE
);

CREATE TABLE likes (
	id SERIAL PRIMARY KEY,
	liked_by INTEGER NOT NULL,		-- who liked something
	liked_post INTEGER,				-- the post being liked if not null
	liked_image INTEGER, 			-- the image being liked if not null

	CONSTRAINT fk_liked_by
		FOREIGN KEY (liked_by)
		REFERENCES users(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_liked_post
		FOREIGN KEY (liked_post)
		REFERENCES posts(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_liked_image
		FOREIGN KEY (liked_image)
		REFERENCES images(id)
		ON DELETE CASCADE
);







