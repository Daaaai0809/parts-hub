CREATE TABLE "users" (
	"id" uuid PRIMARY KEY NOT NULL,
	"username" char(32) NOT NULL,
	"email" text NOT NULL,
	"line_id" text,
	"password" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "users_username_unique" UNIQUE("username"),
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_line_id_unique" UNIQUE("line_id")
);
