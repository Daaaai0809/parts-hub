CREATE TABLE "car_grades" (
	"id" uuid PRIMARY KEY NOT NULL,
	"car_id" uuid,
	"grade" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "cars" (
	"id" uuid PRIMARY KEY NOT NULL,
	"manufacturer_id" uuid,
	"name" text NOT NULL,
	"year" integer NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "custom_parts_detail" (
	"id" uuid PRIMARY KEY NOT NULL,
	"parts_id" uuid,
	"description" text NOT NULL,
	"is_legal" boolean,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "manufacturers" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "notificate_conditions" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" uuid,
	"parts_manufacturer_id" uuid,
	"car_id" uuid,
	"car_grade_id" uuid,
	"part_category_id" uuid,
	"part_sub_category_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "notification_parts" (
	"id" uuid PRIMARY KEY NOT NULL,
	"notification_id" uuid,
	"part_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "notifications" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" uuid,
	"notificate_condition_id" uuid,
	"title" text NOT NULL,
	"message" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "part_categories" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "part_diversions" (
	"parts_id" uuid,
	"diversion_car_id" uuid,
	"diversion_car_grade_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "part_sub_categories" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "parts" (
	"id" uuid PRIMARY KEY NOT NULL,
	"parts_manufacturer_id" uuid,
	"car_id" uuid,
	"car_grade_id" uuid,
	"name" text NOT NULL,
	"is_custom_parts" boolean DEFAULT false NOT NULL,
	"can_diversion" boolean DEFAULT false NOT NULL,
	"damage_level" integer DEFAULT 0 NOT NULL,
	"part_category_id" uuid,
	"part_sub_category_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "parts_manufacturers" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_details" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" uuid,
	"first_name" text NOT NULL,
	"last_name" text NOT NULL,
	"phone_number" text NOT NULL,
	"address" text NOT NULL,
	"city" text NOT NULL,
	"state" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_evaluations" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" uuid,
	"score" integer NOT NULL,
	"description" text,
	"created_at" timestamp with time zone
);
--> statement-breakpoint
ALTER TABLE "car_grades" ADD CONSTRAINT "car_grades_car_id_cars_id_fk" FOREIGN KEY ("car_id") REFERENCES "public"."cars"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cars" ADD CONSTRAINT "cars_manufacturer_id_manufacturers_id_fk" FOREIGN KEY ("manufacturer_id") REFERENCES "public"."manufacturers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "custom_parts_detail" ADD CONSTRAINT "custom_parts_detail_parts_id_parts_id_fk" FOREIGN KEY ("parts_id") REFERENCES "public"."parts"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notificate_conditions" ADD CONSTRAINT "notificate_conditions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notificate_conditions" ADD CONSTRAINT "notificate_conditions_parts_manufacturer_id_parts_manufacturers_id_fk" FOREIGN KEY ("parts_manufacturer_id") REFERENCES "public"."parts_manufacturers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notificate_conditions" ADD CONSTRAINT "notificate_conditions_car_id_cars_id_fk" FOREIGN KEY ("car_id") REFERENCES "public"."cars"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notificate_conditions" ADD CONSTRAINT "notificate_conditions_car_grade_id_car_grades_id_fk" FOREIGN KEY ("car_grade_id") REFERENCES "public"."car_grades"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notificate_conditions" ADD CONSTRAINT "notificate_conditions_part_category_id_part_categories_id_fk" FOREIGN KEY ("part_category_id") REFERENCES "public"."part_categories"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notificate_conditions" ADD CONSTRAINT "notificate_conditions_part_sub_category_id_part_sub_categories_id_fk" FOREIGN KEY ("part_sub_category_id") REFERENCES "public"."part_sub_categories"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notification_parts" ADD CONSTRAINT "notification_parts_notification_id_notifications_id_fk" FOREIGN KEY ("notification_id") REFERENCES "public"."notifications"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notification_parts" ADD CONSTRAINT "notification_parts_part_id_parts_id_fk" FOREIGN KEY ("part_id") REFERENCES "public"."parts"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_notificate_condition_id_notificate_conditions_id_fk" FOREIGN KEY ("notificate_condition_id") REFERENCES "public"."notificate_conditions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "part_diversions" ADD CONSTRAINT "part_diversions_parts_id_parts_id_fk" FOREIGN KEY ("parts_id") REFERENCES "public"."parts"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "part_diversions" ADD CONSTRAINT "part_diversions_diversion_car_id_cars_id_fk" FOREIGN KEY ("diversion_car_id") REFERENCES "public"."cars"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "part_diversions" ADD CONSTRAINT "part_diversions_diversion_car_grade_id_car_grades_id_fk" FOREIGN KEY ("diversion_car_grade_id") REFERENCES "public"."car_grades"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "parts" ADD CONSTRAINT "parts_parts_manufacturer_id_parts_manufacturers_id_fk" FOREIGN KEY ("parts_manufacturer_id") REFERENCES "public"."parts_manufacturers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "parts" ADD CONSTRAINT "parts_car_id_cars_id_fk" FOREIGN KEY ("car_id") REFERENCES "public"."cars"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "parts" ADD CONSTRAINT "parts_car_grade_id_car_grades_id_fk" FOREIGN KEY ("car_grade_id") REFERENCES "public"."car_grades"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "parts" ADD CONSTRAINT "parts_part_category_id_part_categories_id_fk" FOREIGN KEY ("part_category_id") REFERENCES "public"."part_categories"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "parts" ADD CONSTRAINT "parts_part_sub_category_id_part_sub_categories_id_fk" FOREIGN KEY ("part_sub_category_id") REFERENCES "public"."part_sub_categories"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_details" ADD CONSTRAINT "user_details_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_evaluations" ADD CONSTRAINT "user_evaluations_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;