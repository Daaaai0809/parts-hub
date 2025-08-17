import { relations } from 'drizzle-orm';
import {
  boolean,
  char,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: uuid('id').primaryKey(),
  username: char('username', { length: 32 }).notNull().unique(),
  email: text('email').notNull().unique(),
  lineId: text('line_id').unique(),
  password: text('password').notNull(),
  isActive: boolean('is_active').notNull().default(true),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const userRelations = relations(users, ({ one, many }) => ({
  userDetails: one(userDetails, {
    fields: [users.id],
    references: [userDetails.userId],
  }),
  userEvaluations: many(userEvaluations),
  notificateConditions: many(notificateConditions),
  notifications: many(notifications),
}));

export const userDetails = pgTable('user_details', {
  id: uuid('id').primaryKey(),
  userId: uuid('user_id').references(() => users.id),
  firstName: text('first_name').notNull(),
  lastName: text('last_name').notNull(),
  phoneNumber: text('phone_number').notNull(),
  address: text('address').notNull(),
  city: text('city').notNull(),
  state: text('state').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const userEvaluations = pgTable('user_evaluations', {
  id: uuid('id').primaryKey(),
  userId: uuid('user_id').references(() => users.id),
  score: integer('score').notNull(),
  description: text('description'),
  createdAt: timestamp('created_at', { withTimezone: true }),
});

export const manufacturers = pgTable('manufacturers', {
  id: uuid('id').primaryKey(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const manufacturerRelations = relations(manufacturers, ({ many }) => ({
  cars: many(cars),
}));

export const cars = pgTable('cars', {
  id: uuid('id').primaryKey(),
  manufacturerId: uuid('manufacturer_id').references(() => manufacturers.id),
  name: text('name').notNull(),
  year: integer('year').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const carRelations = relations(cars, ({ one, many }) => ({
  manufacturer: one(manufacturers, {
    fields: [cars.manufacturerId],
    references: [manufacturers.id],
  }),
  carGrades: many(carGrades),
  parts: many(parts),
}));

export const carGrades = pgTable('car_grades', {
  id: uuid('id').primaryKey(),
  carId: uuid('car_id').references(() => cars.id),
  grade: text('grade').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const carGradeRelations = relations(carGrades, ({ one, many }) => ({
  car: one(cars, {
    fields: [carGrades.carId],
    references: [cars.id],
  }),
  parts: many(parts),
}));

export const partsManufacturers = pgTable('parts_manufacturers', {
  id: uuid('id').primaryKey(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const partsManufacturerRelations = relations(
  partsManufacturers,
  ({ many }) => ({
    parts: many(parts),
  }),
);

export const parts = pgTable('parts', {
  id: uuid('id').primaryKey(),
  partsManufacturerId: uuid('parts_manufacturer_id').references(
    () => partsManufacturers.id,
  ),
  carId: uuid('car_id').references(() => cars.id),
  carGradeId: uuid('car_grade_id').references(() => carGrades.id),
  name: text('name').notNull(),
  isCustomParts: boolean('is_custom_parts').notNull().default(false),
  canDiversion: boolean('can_diversion').notNull().default(false),
  damageLevel: integer('damage_level').notNull().default(0),
  partCategoryId: uuid('part_category_id').references(() => partCategories.id),
  partSubCategoryId: uuid('part_sub_category_id').references(
    () => partSubCategories.id,
  ),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const partRelations = relations(parts, ({ one, many }) => ({
  partsManufacturer: one(partsManufacturers, {
    fields: [parts.partsManufacturerId],
    references: [partsManufacturers.id],
  }),
  car: one(cars, {
    fields: [parts.carId],
    references: [cars.id],
  }),
  carGrade: one(carGrades, {
    fields: [parts.carGradeId],
    references: [carGrades.id],
  }),
  partCategory: one(partCategories, {
    fields: [parts.partCategoryId],
    references: [partCategories.id],
  }),
  partSubCategory: one(partSubCategories, {
    fields: [parts.partSubCategoryId],
    references: [partSubCategories.id],
  }),
  customPartsDetail: one(customPartsDetail, {
    fields: [parts.id],
    references: [customPartsDetail.partsId],
  }),
  partDiversions: many(partDiversions),
  notificationParts: many(notificationParts),
}));

export const partCategories = pgTable('part_categories', {
  id: uuid('id').primaryKey(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const partCategoryRelations = relations(partCategories, ({ many }) => ({
  parts: many(parts),
}));

export const partSubCategories = pgTable('part_sub_categories', {
  id: uuid('id').primaryKey(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const partSubCategoryRelations = relations(
  partSubCategories,
  ({ many }) => ({
    parts: many(parts),
  }),
);

export const customPartsDetail = pgTable('custom_parts_detail', {
  id: uuid('id').primaryKey(),
  partsId: uuid('parts_id').references(() => parts.id),
  description: text('description').notNull(),
  isLegal: boolean('is_legal'),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const customPartsDetailRelations = relations(
  customPartsDetail,
  ({ one }) => ({
    parts: one(parts, {
      fields: [customPartsDetail.partsId],
      references: [parts.id],
    }),
  }),
);

export const partDiversions = pgTable('part_diversions', {
  partsId: uuid('parts_id').references(() => parts.id),
  diversionCarId: uuid('diversion_car_id').references(() => cars.id),
  diversionCarGradeId: uuid('diversion_car_grade_id').references(
    () => carGrades.id,
  ),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const partDiversionRelations = relations(partDiversions, ({ one }) => ({
  parts: one(parts, {
    fields: [partDiversions.partsId],
    references: [parts.id],
  }),
  diversionCar: one(cars, {
    fields: [partDiversions.diversionCarId],
    references: [cars.id],
  }),
  diversionCarGrade: one(carGrades, {
    fields: [partDiversions.diversionCarGradeId],
    references: [carGrades.id],
  }),
}));

export const notificateConditions = pgTable('notificate_conditions', {
  id: uuid('id').primaryKey(),
  userId: uuid('user_id').references(() => users.id),
  partsManufacturerId: uuid('parts_manufacturer_id').references(
    () => partsManufacturers.id,
  ),
  carId: uuid('car_id').references(() => cars.id),
  carGradeId: uuid('car_grade_id').references(() => carGrades.id),
  partCategoryId: uuid('part_category_id').references(() => partCategories.id),
  partSubCategoryId: uuid('part_sub_category_id').references(
    () => partSubCategories.id,
  ),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true })
    .notNull()
    .defaultNow()
    .$onUpdate(() => new Date()),
});

export const notificateConditionRelations = relations(
  notificateConditions,
  ({ one, many }) => ({
    user: one(users, {
      fields: [notificateConditions.userId],
      references: [users.id],
    }),
    notification: many(notifications),
  }),
);

export const notifications = pgTable('notifications', {
  id: uuid('id').primaryKey(),
  userId: uuid('user_id').references(() => users.id),
  notificateConditionId: uuid('notificate_condition_id').references(
    () => notificateConditions.id,
  ),
  title: text('title').notNull(),
  message: text('message').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
});

export const notificationRelations = relations(
  notifications,
  ({ one, many }) => ({
    notificateCondition: one(notificateConditions, {
      fields: [notifications.notificateConditionId],
      references: [notificateConditions.id],
    }),
    notificationParts: many(notificationParts),
  }),
);

export const notificationParts = pgTable('notification_parts', {
  id: uuid('id').primaryKey(),
  notificationId: uuid('notification_id').references(() => notifications.id),
  partId: uuid('part_id').references(() => parts.id),
  createdAt: timestamp('created_at', { withTimezone: true })
    .notNull()
    .defaultNow(),
});

export const notificationPartRelations = relations(
  notificationParts,
  ({ one }) => ({
    notification: one(notifications, {
      fields: [notificationParts.notificationId],
      references: [notifications.id],
    }),
    part: one(parts, {
      fields: [notificationParts.partId],
      references: [parts.id],
    }),
  }),
);
