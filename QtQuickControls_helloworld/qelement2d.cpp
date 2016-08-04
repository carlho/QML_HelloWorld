#include "qelement2d.h"

#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>

QElement2d::QElement2d(QQuickItem *parent)
        : QQuickItem(parent)
        , m_p1(0, 0)
        , m_p2(1, 1)
    {
        setFlag(ItemHasContents, true);
    }


QElement2d::~QElement2d()
{
}


void QElement2d::setP1(const QPointF &p)
{
    if (p == m_p1)
        return;

    m_p1 = p;
    emit p1Changed(p);
    update();
}

void QElement2d::setP2(const QPointF &p)
{
    if (p == m_p2)
        return;

    m_p2 = p;
    emit p2Changed(p);
    update();
}

QSGNode *QElement2d::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = 0;
    QSGGeometry *geometry = 0;

    if (!oldNode)
    {
        node = new QSGGeometryNode;

        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 2);    // Set vertex count to 2 for debugging /CH
        geometry->setLineWidth(2);
        geometry->setDrawingMode(GL_LINE_STRIP);
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);

        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
        material->setColor(QColor(255, 0, 0));
        node->setMaterial(material);
        node->setFlag(QSGNode::OwnsMaterial);
    } else {
        node = static_cast<QSGGeometryNode *>(oldNode);
        geometry = node->geometry();
        }

    QSGGeometry::Point2D *vertices = geometry->vertexDataAsPoint2D();

    QRectF bounds = boundingRect();

    float x = bounds.x() + m_p1.x() * bounds.width();
    float y = bounds.y() + m_p1.y() * bounds.height();
    vertices[0].set(x, y);    // Set node 1

    x = bounds.x() + m_p2.x() * bounds.width();
    y = bounds.y() + m_p2.y() * bounds.width();
    vertices[1].set(x, y);    // Set node 2
    node->markDirty(QSGNode::DirtyGeometry);

    return node;
}
