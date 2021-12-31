"""create test

Revision ID: 78cf87ea8270
Revises: 1dd5b2aac1c7
Create Date: 2021-12-27 14:44:23.043030

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '78cf87ea8270'
down_revision = '1dd5b2aac1c7'
branch_labels = None
depends_on = None


def upgrade():
    op.execute(
        """
        CREATE TABLE test (
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL
        );
        """
    )


def downgrade():
    op.execute(
        """
        DROP TABLE test;
        """
    )
