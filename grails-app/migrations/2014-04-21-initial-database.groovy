databaseChangeLog = {

	changeSet(author: "atreyac (generated)", id: "1398139728144-1") {
		createTable(tableName: "beneficiary") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "address_line1", type: "VARCHAR(255)")

			column(name: "address_line2", type: "VARCHAR(255)")

			column(name: "city", type: "VARCHAR(255)")

			column(name: "country", type: "VARCHAR(255)")

			column(name: "email", type: "VARCHAR(255)")

			column(name: "first_name", type: "VARCHAR(255)")

			column(name: "gender", type: "VARCHAR(255)")

			column(name: "last_name", type: "VARCHAR(255)")

			column(name: "postal_code", type: "VARCHAR(255)")

			column(name: "state_or_province", type: "VARCHAR(255)")

			column(name: "telephone", type: "VARCHAR(255)")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-2") {
		createTable(tableName: "blog") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "author", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "content", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "date", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "enabled", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "snippet", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-3") {
		createTable(tableName: "community") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "manager_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-4") {
		createTable(tableName: "community_user") {
			column(name: "community_members_id", type: "BIGINT")

			column(name: "user_id", type: "BIGINT")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-5") {
		createTable(tableName: "contribution") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "amount", type: "DOUBLE") {
				constraints(nullable: "false")
			}

			column(name: "credit_id", type: "BIGINT")

			column(name: "date", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "project_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "reward_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "contributions_idx", type: "INT")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-6") {
		createTable(tableName: "credit") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "amount", type: "DOUBLE") {
				constraints(nullable: "false")
			}

			column(name: "community_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date", type: "DATETIME") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-7") {
		createTable(tableName: "facebook_user") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "access_token", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "access_token_expires", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "uid", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-8") {
		createTable(tableName: "image") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "bytes", type: "MEDIUMBLOB") {
				constraints(nullable: "false")
			}

			column(name: "content_type", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-9") {
		createTable(tableName: "project") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "amount", type: "DOUBLE") {
				constraints(nullable: "false")
			}

			column(name: "beneficiary_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "category", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "days", type: "INT") {
				constraints(nullable: "false")
			}

			column(name: "fund_raising_for", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "fund_raising_reason", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "image_id", type: "BIGINT")

			column(name: "image_url", type: "VARCHAR(255)")

			column(name: "story", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "validated", type: "BIT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-10") {
		createTable(tableName: "project_comment") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "comment", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "date", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "project_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "comments_idx", type: "INT")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-11") {
		createTable(tableName: "project_reward") {
			column(name: "project_rewards_id", type: "BIGINT")

			column(name: "reward_id", type: "BIGINT")

			column(name: "rewards_idx", type: "INT")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-12") {
		createTable(tableName: "reward") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "image_id", type: "BIGINT")

			column(name: "price", type: "DOUBLE") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-13") {
		createTable(tableName: "role") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "authority", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-14") {
		createTable(tableName: "user") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "account_expired", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "account_locked", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "confirm_code", type: "VARCHAR(255)")

			column(name: "email", type: "VARCHAR(255)")

			column(name: "enabled", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "first_name", type: "VARCHAR(255)")

			column(name: "last_name", type: "VARCHAR(255)")

			column(name: "password", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "password_expired", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "reset_code", type: "VARCHAR(255)")

			column(name: "username", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-15") {
		createTable(tableName: "user_role") {
			column(name: "role_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-16") {
		addPrimaryKey(columnNames: "role_id, user_id", tableName: "user_role")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-35") {
		createIndex(indexName: "uid", tableName: "facebook_user", unique: "true") {
			column(name: "uid")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-36") {
		createIndex(indexName: "authority", tableName: "role", unique: "true") {
			column(name: "authority")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-37") {
		createIndex(indexName: "username", tableName: "user", unique: "true") {
			column(name: "username")
		}
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-17") {
		addForeignKeyConstraint(baseColumnNames: "manager_id", baseTableName: "community", baseTableSchemaName: "fedudb", constraintName: "FKA7C52FE9181A5476", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-18") {
		addForeignKeyConstraint(baseColumnNames: "community_members_id", baseTableName: "community_user", baseTableSchemaName: "fedudb", constraintName: "FK322AFE61F4868502", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "community", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-19") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "community_user", baseTableSchemaName: "fedudb", constraintName: "FK322AFE617A9C9B98", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-20") {
		addForeignKeyConstraint(baseColumnNames: "credit_id", baseTableName: "contribution", baseTableSchemaName: "fedudb", constraintName: "FK5203A4103B1BAD58", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "credit", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-21") {
		addForeignKeyConstraint(baseColumnNames: "project_id", baseTableName: "contribution", baseTableSchemaName: "fedudb", constraintName: "FK5203A41084CCEC9C", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "project", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-22") {
		addForeignKeyConstraint(baseColumnNames: "reward_id", baseTableName: "contribution", baseTableSchemaName: "fedudb", constraintName: "FK5203A4107121B998", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "reward", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-23") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "contribution", baseTableSchemaName: "fedudb", constraintName: "FK5203A4107A9C9B98", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-24") {
		addForeignKeyConstraint(baseColumnNames: "community_id", baseTableName: "credit", baseTableSchemaName: "fedudb", constraintName: "FKAF65AAF9C647A21C", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "community", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-25") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "facebook_user", baseTableSchemaName: "fedudb", constraintName: "FK609FD5A47A9C9B98", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-26") {
		addForeignKeyConstraint(baseColumnNames: "beneficiary_id", baseTableName: "project", baseTableSchemaName: "fedudb", constraintName: "FKED904B1980DF381C", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "beneficiary", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-27") {
		addForeignKeyConstraint(baseColumnNames: "image_id", baseTableName: "project", baseTableSchemaName: "fedudb", constraintName: "FKED904B19B4EBA5DC", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "image", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-28") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "project", baseTableSchemaName: "fedudb", constraintName: "FKED904B197A9C9B98", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-29") {
		addForeignKeyConstraint(baseColumnNames: "project_id", baseTableName: "project_comment", baseTableSchemaName: "fedudb", constraintName: "FKA9F9B73984CCEC9C", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "project", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-30") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "project_comment", baseTableSchemaName: "fedudb", constraintName: "FKA9F9B7397A9C9B98", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-31") {
		addForeignKeyConstraint(baseColumnNames: "reward_id", baseTableName: "project_reward", baseTableSchemaName: "fedudb", constraintName: "FK375203157121B998", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "reward", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-32") {
		addForeignKeyConstraint(baseColumnNames: "image_id", baseTableName: "reward", baseTableSchemaName: "fedudb", constraintName: "FKC84F4F2FB4EBA5DC", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "image", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-33") {
		addForeignKeyConstraint(baseColumnNames: "role_id", baseTableName: "user_role", baseTableSchemaName: "fedudb", constraintName: "FK143BF46AD571D7B8", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "role", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

	changeSet(author: "atreyac (generated)", id: "1398139728144-34") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "user_role", baseTableSchemaName: "fedudb", constraintName: "FK143BF46A7A9C9B98", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "user", referencedTableSchemaName: "fedudb", referencesUniqueColumn: "false")
	}

}
